module InscricaoEstadual
  module DF
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 13
      return false unless code.start_with?("07")

      base = code[0..10].chars.map(&:to_i)
      dv1 = code[11].to_i
      dv2 = code[12].to_i

      calculado1 = calcula_dv(base)
      return false unless calculado1 == dv1

      base_com_dv1 = base + [dv1]
      calculado2 = calcula_dv(base_com_dv1)

      calculado2 == dv2
    end

    def generate
      base = [0, 7] + Array.new(9) { rand(0..9) }

      dv1 = calcula_dv(base)
      dv2 = calcula_dv(base + [dv1])

      (base + [dv1, dv2]).join
    end

    def calcula_dv(digits)
      pesos = (2..9).to_a.cycle.take(digits.size).reverse

      soma = digits.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv = 11 - resto
      dv = 0 if dv >= 10

      dv
    end
  end
end
