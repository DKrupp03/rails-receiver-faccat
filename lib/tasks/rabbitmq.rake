# lib/tasks/rabbitmq.rake

namespace :rabbitmq do
  desc "Consome mensagens da fila RabbitMQ"
  task consume: :environment do
    require 'bunny'

    conn = Bunny.new(hostname: 'rabbitmq', username: 'guest', password: 'guest')
    conn.start

    channel = conn.create_channel
    queue = channel.queue('users')

    begin
      queue.subscribe(block: true) do |_delivery_info, _properties, body|
        UserMailer.user_register(JSON.parse(body)).deliver_now
      end
    rescue Interrupt => _
      conn.close
    end
  end
end
