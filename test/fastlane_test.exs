defmodule FastlaneTest do
  use ExUnit.Case
  doctest Fastlane

  @log "2018-07-17T00_00_00.000-5oiKBcQg_aIr998AAAAA.log"

  test "parses a log file" do
    logs =
      File.read!("./test/fixtures/#{@log}")
      |> Fastlane.read()

    assert length(logs) == 3

    log = List.first(logs)
    assert log["fastly_info.state"] == "PASS"
    assert log["now.sec"] == "1531785599"
    assert log["resp.status"] == "204"
  end
end
