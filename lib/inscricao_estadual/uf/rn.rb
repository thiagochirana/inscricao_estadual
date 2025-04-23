module InscricaoEstadual
  module RN
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless [9, 10].include?(code.length)
      return false unless code.start_with?("20")

      body = code[0..-2].chars.map(&:to_i)
      dv_real = code[-1].to_i

      pesos = body.size == 8 ? [9, 8, 7, 6, 5, 4, 3, 2] : [10, 9, 8, 7, 6, 5, 4, 3, 2]

      soma = body.each_with_index.sum { |n, i| n * pesos[i] }
      resto = (soma * 10) % 11
      dv_calc = resto == 10 ? 0 : resto

      dv_calc == dv_real
    end

    def generate(length: 9)
      raise ArgumentError, "length must be 9 or 10" unless [9, 10].include?(length)

      prefix = [2, 0]
      body = prefix + Array.new(length - 3) { rand(0..9) }

      pesos = body.size == 8 ? [9, 8, 7, 6, 5, 4, 3, 2] : [10, 9, 8, 7, 6, 5, 4, 3, 2]

      soma = body.each_with_index.sum { |n, i| n * pesos[i] }
      resto = (soma * 10) % 11
      dv = resto == 10 ? 0 : resto

      (body + [dv]).join
    end
  end
end
