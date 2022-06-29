class TokenGenerationService
  def self.generate
    SecureRandom.hex # metodo hex es para strings
  end
end
