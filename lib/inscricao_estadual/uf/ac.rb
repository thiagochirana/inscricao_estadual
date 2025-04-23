# frozen_string_literal: true

module InscricaoEstadual
  module AC
    module_function

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 13
      return false unless code.start_with?("01")

      body = code[0..10].chars.map(&:to_i)
      dv1 = code[11].to_i
      dv2 = code[12].to_i

      # Primeiro dígito verificador
      pesos1 = [4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
      soma1 = body.each_with_index.sum { |n, i| n * pesos1[i] }
      resto1 = soma1 % 11
      calculado1 = [10, 11].include?(resto1) ? 0 : 11 - resto1

      return false unless calculado1 == dv1

      # Segundo dígito verificador
      body_com_dv1 = body + [calculado1]
      pesos2 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
      soma2 = body_com_dv1.each_with_index.sum { |n, i| n * pesos2[i] }
      resto2 = soma2 % 11
      calculado2 = [10, 11].include?(resto2) ? 0 : 11 - resto2

      calculado2 == dv2
    end

    def generate
      base = [0, 1] + Array.new(9) { rand(0..9) }
      pesos1 = [4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
      soma1 = base.each_with_index.sum { |n, i| n * pesos1[i] }
      resto1 = soma1 % 11
      dv1 = [10, 11].include?(resto1) ? 0 : 11 - resto1

      base_com_dv1 = base + [dv1]
      pesos2 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
      soma2 = base_com_dv1.each_with_index.sum { |n, i| n * pesos2[i] }
      resto2 = soma2 % 11
      dv2 = [10, 11].include?(resto2) ? 0 : 11 - resto2

      (base + [dv1, dv2]).join
    end
  end
end
