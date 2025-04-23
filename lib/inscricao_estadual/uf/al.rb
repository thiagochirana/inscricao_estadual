module InscricaoEstadual
  module AL
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 9
      return false unless code.start_with?("24")

      body = code[0..7].chars.map(&:to_i)
      dv = code[8].to_i
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = body.each_with_index.sum { |n, i| n * pesos[i] }
      produto = soma * 10
      resto = produto % 11

      calculado = (resto == 10 ? 0 : resto)

      calculado == dv
    end

    def generate(tipo_empresa = 0)
      raise ArgumentError, "Tipo de empresa inválido" unless [0, 3, 5, 7, 8].include?(tipo_empresa)

      base = [2, 4, tipo_empresa] + Array.new(5) { rand(0..9) }
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      produto = soma * 10
      resto = produto % 11
      dv = (resto == 10 ? 0 : resto)

      (base + [dv]).join
    end
  end
end
