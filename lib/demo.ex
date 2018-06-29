defmodule Viz.Demo do
  @moduledoc """
  Simple demo!
  """

  alias Viz.Counter, as: Visualization

  use Uderzo.GenRenderer
  require Logger

  def run do
    t_start = timestamp()
    Uderzo.GenRenderer.start_link(__MODULE__, "Uderzo Viz Demo", 800, 600, 5, {t_start, 0})
    Process.sleep(2000)
  end

  def init_renderer({t_start, frame}) do
    Visualization.init()
    {:ok, {t_start, frame}}
  end

  def render_frame(width, height, mx, my, {t_start, frame}) do
    if rem(frame, 100) == 0 do
      Logger.info("Rendering frame #{frame}")
    end

    time = timestamp() - t_start
    Visualization.render(width, height, mx, my, time, frame)
    {:ok, {t_start, frame + 1}}
  end

  defp timestamp, do: :erlang.system_time(:nanosecond) / 1_000_000_000.0
end
