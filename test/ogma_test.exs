defmodule OgmaTest do
  use ExUnit.Case

  test "subscribing to a topic" do
    Ogma.subscribe("foo")
    Ogma.publish("foo", "bar")

    assert_receive "bar"
  end

  test "a process should only receive messages from subscribed topics" do
    Ogma.subscribe("bar")

    Ogma.publish("foo", :foo)
    Ogma.publish("bar", :bar)

    refute_receive :foo
    assert_receive :bar
  end

  test "unsubscribing from a topic" do
    Ogma.subscribe("foo")
    Ogma.unsubscribe("foo")
    Ogma.publish("foo", "bar")

    refute_receive "bar"
  end
end
