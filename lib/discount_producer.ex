defmodule DiscountProducer do
  @topic "ofertas"

  def execute, do: %{name: "Playstation #{:rand.uniform(1000)}", discount: :rand.uniform(100), price: :rand.uniform(1000000)} |> send_msg()
  def executex, do: %{name: "Xbox #{:rand.uniform(1000)}", discount: :rand.uniform(100), price: :rand.uniform(1000000)} |> send_msg()

  def send_msg(payload) do
    client_id = :discount_producer
    hosts = [localhost: 9092]

    :ok = :brod.start_client(hosts, client_id)
    :ok = :brod.start_producer(client_id, @topic, [])

    :brod.produce(
      client_id,
      @topic,
      0,
      _key = "",
      payload
      |> Jason.encode!()
    )
  end
end
