--[[
  tables.lua — pandoc Lua filter for the Horizon Europe DMP Word export.

  Pandoc cannot express full-width tables or per-column cell shading when it
  converts the HTML header tables to DOCX. This filter rebuilds each table as
  raw OOXML so the result matches the official reference template:

    * table stretched to the full text width (100%)
    * first (label) column shaded grey (D9D9D9), value cells white
    * a fully merged, grey, bold header row

  It runs inside pandoc (``--lua-filter=src/tables.lua``), so it works both
  locally and in the DSW document worker's pandoc step.
]]

local stringify = pandoc.utils.stringify

local GREY = "D9D9D9"
local WHITE = "FFFFFF"

local function esc(s)
  s = s:gsub("&", "&amp;")
  s = s:gsub("<", "&lt;")
  s = s:gsub(">", "&gt;")
  return s
end

local function run(text, bold)
  local rpr = bold and "<w:rPr><w:b/></w:rPr>" or ""
  return "<w:r>" .. rpr .. '<w:t xml:space="preserve">' .. esc(text) .. "</w:t></w:r>"
end

local function cell(text, fill, width, gridspan, bold)
  local span = ""
  if gridspan and gridspan > 1 then
    span = '<w:gridSpan w:val="' .. gridspan .. '"/>'
  end
  return table.concat({
    "<w:tc><w:tcPr>",
    '<w:tcW w:w="' .. width .. '" w:type="pct"/>',
    span,
    '<w:shd w:val="clear" w:color="auto" w:fill="' .. fill .. '"/>',
    "</w:tcPr>",
    "<w:p>" .. run(text, bold) .. "</w:p>",
    "</w:tc>",
  })
end

-- Build a list of { text = ..., span = ... } from a list of AST rows.
local function read_rows(ast_rows)
  local out = {}
  for _, row in ipairs(ast_rows) do
    local cells = {}
    for _, c in ipairs(row.cells) do
      cells[#cells + 1] = { text = stringify(c.contents), span = c.col_span or 1 }
    end
    out[#out + 1] = cells
  end
  return out
end

local function emit_row(cells, is_header, ncols)
  local xml = { "<w:tr>" }
  if #cells == 1 and (cells[1].span or 1) >= ncols then
    -- Fully merged header row: grey + bold across the whole width.
    xml[#xml + 1] = cell(cells[1].text, GREY, 5000, ncols, true)
  else
    local rest = math.max(1, math.floor(3250 / math.max(1, #cells - 1)))
    for i, c in ipairs(cells) do
      if i == 1 then
        xml[#xml + 1] = cell(c.text, GREY, 1750, c.span, is_header)
      else
        xml[#xml + 1] = cell(c.text, WHITE, rest, c.span, false)
      end
    end
  end
  xml[#xml + 1] = "</w:tr>"
  return table.concat(xml)
end

function Table(el)
  local ncols = #el.colspecs
  if ncols == 0 then
    return nil
  end

  local parts = {
    "<w:tbl><w:tblPr>",
    '<w:tblStyle w:val="Table"/>',
    '<w:tblW w:w="5000" w:type="pct"/>',
    '<w:tblLayout w:type="fixed"/>',
    '<w:tblLook w:val="04A0" w:firstRow="1" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="0" w:noVBand="1"/>',
    "</w:tblPr>",
    "<w:tblGrid>",
  }
  local col_w = math.floor(8592 / ncols)
  for _ = 1, ncols do
    parts[#parts + 1] = '<w:gridCol w:w="' .. col_w .. '"/>'
  end
  parts[#parts + 1] = "</w:tblGrid>"

  for _, r in ipairs(read_rows(el.head.rows)) do
    parts[#parts + 1] = emit_row(r, true, ncols)
  end
  for _, body in ipairs(el.bodies) do
    for _, r in ipairs(read_rows(body.body)) do
      parts[#parts + 1] = emit_row(r, false, ncols)
    end
  end
  for _, r in ipairs(read_rows(el.foot.rows)) do
    parts[#parts + 1] = emit_row(r, false, ncols)
  end

  parts[#parts + 1] = "</w:tbl>"
  return pandoc.RawBlock("openxml", table.concat(parts))
end
