defmodule Fastlane do
  @moduledoc """
  Documentation for Fastlane.
  """

  @doc """
  Parses a log file into a list of log maps
  """
  def read(logfile) do
    logfile
    |> String.split("\n")
    |> Stream.filter(&String.length(&1) > 0)
    |> Enum.map(&to_log(headers(), &1))
  end

  defp headers do
    ~r/%{(.*?)}V/
    |> Regex.scan(format())
    |> Enum.map(&List.last/1)
  end

  defp to_log(headers, line) do
    headers
    |> Enum.zip(String.split(line, ","))
    |> Map.new()
  end

  defp format do
    "%{now.sec}V,%{time.start.msec}V,%{time.end.msec}V,%{time.to_first_byte}V,%{time.elapsed}V,%{req.bytes_read}V,%{req.body_bytes_read}V,%{resp.http.Content-Length}V,%{server.region}V,%{req.http.Fastly-Client-IP}V,%{resp.status}V,%{fastly_info.state}V,%{var.cache_status}V,%{var.request_type}V,%{var.escaped_request_proto}V,%{var.escaped_request_method}V,%{var.escaped_request_url}V,%{var.escaped_referrer}V,%{var.escaped_user_agent}V"
  end
end
