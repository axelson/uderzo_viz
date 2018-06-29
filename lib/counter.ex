defmodule Viz.Counter do
  use Clixir
  @clixir_header "counter"

  def init do
    base_dir = Application.app_dir(:viz, ".")
    priv_dir = Path.absname("priv", base_dir)

    create_font("sans", Path.join(priv_dir, "SourceCodePro-Regular.ttf"))
  end

  def render(width, height, _mx, _my, time, frame) do
    display_count(frame)
  end

  def_c create_font(name, file_name) do
    cdecl "char *": [name, file_name]
    cdecl int: retval

    assert(nvgCreateFont(vg, name, file_name) >= 0)
  end

  def display_count(count) do
    draw_text("hi", 16.0, 20, 50)
  end

  def draw_text(text, size, x, y) do
    draw_text_c(text, String.length(text), size, x, y)
  end

  def_c draw_text_c(text, text_length, size, x, y) do
    cdecl "char *": text
    cdecl long: text_length
    cdecl double: [size, x, y]

    nvgFontSize(vg, size)
    nvgFontFace(vg, "sans")
    nvgTextAlign(vg, NVG_ALIGN_LEFT|NVG_ALIGN_TOP)
    nvgFillColor(vg, nvgRGBA(255, 255, 255, 255))
    nvgText(vg, x, y, text, text + text_length)
  end
end
