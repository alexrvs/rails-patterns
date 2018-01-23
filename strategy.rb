require 'base64'

class TextMessage

  attr_accessor :encryptor
  attr_reader :original_message


  def initialize(original_message, encryptor)
    @encryptor =encryptor
    @original_message = original_message

  end

  def encrypt_me
    encryptor.encrypt(self)
  end

end

class SimpleEncryptor

  ALPHABET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  ENCODING = 'MOhqm0PnycUZeLdK8YvDCgNfb7FJtiHT52BrxoAkas9RWlXpEujSGI64VzQ31w'

  def encrypt(objTextMessage)
    objTextMessage.original_message.tr(ALPHABET, ENCODING)
  end

end


class Base64Encryptor

  def encrypt(objTextMessage)
    Base64.encode64(objTextMessage.original_message)
  end

end

class AESEncryptor

  KEY = 'dsfi434n534df0v0bn23324dfgdfgdf4353454'

  def encrypt(objTextMessage)
    AES.encrypt(objTextMessage.original_message, KEY)
  end
end


puts '---------------Simple Encrypt----------------'
message = TextMessage.new('my secret secret message', SimpleEncryptor.new)
puts message.encrypt_me

puts '---------------BASE64----------------'
message.encryptor = Base64Encryptor.new
puts message.encrypt_me