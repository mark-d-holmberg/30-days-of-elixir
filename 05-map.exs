# http://elixir-lang.org/docs/stable/elixir/Map.html

ExUnit.start

defmodule MapTest do
  use ExUnit.Case

  def sample() do
    %{foo: "bar", baz: "quz"}
  end

  test "Map.get" do
    # assert sample() |> Map.get(:foo) == "bar"
    # assert sample() |> Map.get(:non_existent) == nil

    values = [{:foo, "bar"}, {:non_existent, nil}]

    Enum.each values, fn {k,v} ->
      assert sample() |> Map.get(k) == v
    end

    # assert Map.get(sample(), :foo) == "bar"
    # assert Map.get(sample(), :non_existent) == nil
  end

  test "[]" do
    assert sample()[:foo] == "bar"
    assert sample()[:non_existent] == nil
  end

  test "." do
    assert sample().foo == "bar"
    assert_raise KeyError, fn ->
      sample().non_existent
    end
  end

  test "Map.fetch" do
    {:ok, val} = sample() |> Map.fetch(:foo)
    assert val == "bar"

    :error = sample() |> Map.fetch(:non_existent)

    # {:ok, val} = Map.fetch(sample(), :foo)
    # assert val == "bar"
    # :error = Map.fetch(sample(), :non_existent)
  end

  test "Map.put" do
    # assert Map.put(sample(), :foo, "bob") == %{foo: "bob", baz: "quz"}
    # assert Map.put(sample(), :far, "bar") == %{foo: "bar", baz: "quz", far: "bar"}
    assert sample() |> Map.put(:foo, "bob") == %{foo: "bob", baz: "quz"}
    assert sample() |> Map.put(:far, "bar") == %{foo: "bar", baz: "quz", far: "bar"}
  end

  test "Update map using pattern matching syntax" do
    # You can only update existing keys in this way
    assert %{sample() | foo: "bob"} == %{foo: "bob", baz: "quz"}

    # It doesn"t work if you want to add new keys
    assert_raise KeyError, fn ->
      %{sample() | far: "bob"}
    end
  end

  test "Map.values" do
    # Map does not preserve order of keys, thus we Enum.sort
    # assert Enum.sort(Map.values(sample())) == ["bar", "quz"]
    assert sample() |> Map.values |> Enum.sort == ["bar", "quz"]
  end
end

