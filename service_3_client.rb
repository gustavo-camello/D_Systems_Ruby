require 'grpc'

def main
  hostname = ARGV.size > 1 ?  ARGV[1] : 'localhost:50051'
  stub = Service3::SavePassword::Stub.new(hostname, :this_channel_is_insecure)

  begin
    message = stub.save_password(Service3::RequestMessage.new(password: "12585")).message
    p Service3::ResponseMessage.new().message
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end

  stub2 = Service3::CheckPassword::Stub.new(hostname, :this_channel_is_insecure)

  begin
    message = stub.check_password(Service3::RequestMessage.new(password: "111")).message
    p Service3::ResponseMessage.new().message
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end

  stub3 = Service3::OpenTheDoor::Stub.new(hostname, :this_channel_is_insecure)

  begin
    message = stub.open_the_door(Service3::RequestMessage).message
    p Service3::ResponseMessage.new().message
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end
end
