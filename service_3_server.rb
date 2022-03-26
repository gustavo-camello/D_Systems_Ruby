require 'grpc'
require 'service_3_pb'

class Service3Server
  def save_password(req_message, _unused_call)
    password = req_message

    Service3::ResponseMessage.new(message: "The correct password was saved.")
  end

  def check_password(req_message, res_message)
    response = ""

    if (req_message.password === res_message)
      response = "The password is correct."
    elsif
      response = "The password is incorrect."
    end

    Service3::ResponseMessage.new(message: response)
  end

  def open_the_door(req_message, res_message)
    response = ""
    if (req_message === "The password is correct.")
      response = "Open the door"
    elsif (req_message === "The password is incorrect.")
      response = "Not Authorized, keep the door close"
    end

    Service3::ResponseMessage.new(message: response)
  end

  def main
    s = GRPC::RpcServer.new
    s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
    s.handle(Service3Server)

    s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
  end

end
