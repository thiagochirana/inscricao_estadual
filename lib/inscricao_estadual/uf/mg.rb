module InscricaoEstadual
  module MG
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 13

      base = code[0..10]
      dv1 = code[11].to_i
      dv2 = code[12].to_i

      calc_dv1 = calcula_dv1(base)
      return false unless calc_dv1 == dv1

      calc_dv2 = calcula_dv2(base + calc_dv1.to_s)
      calc_dv2 == dv2
    end

    def generate
      base = Array.new(11) { rand(0..9) }
      dv1 = calcula_dv1(base.join)
      dv2 = calcula_dv2(base.join + dv1.to_s)

      (base + [dv1, dv2]).join
    end

    private

    def calcula_dv1(number)
      # insere zero técnico na 4ª posição (após os 3 primeiros dígitos)
      digits = number.chars.map(&:to_i)
      digits.insert(3, 0)

      soma = digits.each_with_index.sum do |n, i|
        peso = (i.even? ? 1 : 2)
        mult = n * peso
        mult < 10 ? mult : mult.digits.sum
      end

      prox_dezena = (soma / 10.0).ceil * 10
      dv1 = prox_dezena - soma
      dv1 == 10 ? 0 : dv1
    end

    def calcula_dv2(number)
      pesos = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 2, 3]
      soma = number.chars.map(&:to_i).each_with_index.sum { |n, i| n * pesos.reverse[i] }

      resto = soma % 11
      dv2 = 11 - resto
      dv2 = 0 if [0, 1].include?(resto)
      dv2
    end
  end
end
