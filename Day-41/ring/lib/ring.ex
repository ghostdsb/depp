defmodule Ring do
  @moduledoc """
  Documentation for Ring.
  """
  def  create_processes(n) do
    1..n
    |> Enum.map(fn _ -> spawn( fn -> loop() end) end)
  end

  defp loop do
    receive do
      {:link, link_to} when is_pid(link_to)->
        Process.link(link_to)
        loop()
      :trap_exit ->
        Process.flag(:trap_exit, true)
        loop()
      :crash -> 1/0
      {:EXIT, pid , reason} ->
        IO.puts( "#{inspect self()} recieved {:EXIT, #{inspect pid}, #{reason}}")
        loop()
    end
  end

  def link_processes(procs) do
    link_processes(procs, [])
  end

  defp link_processes([proc1, proc2|rest], linked) do
    send(proc1, {:link,  proc2})
    link_processes([proc2|rest], [proc1|linked])
  end

  defp link_processes([proc|[]], linked) do
    send(proc, {:link, linked |> List.last})
    :ok
  end
end
