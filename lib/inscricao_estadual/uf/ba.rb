module InscricaoEstadual
  module BA
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless [8, 9].include?(code.length)

      base_digits = code.length == 8 ? code[0..5] : code[0..6]
      dv2 = code[-1].to_i
      dv1 = code[-2].to_i

      modulo = define_modulo(code)

      # 2º dígito
      pesos2 = (2..(base_digits.length + 1)).to_a.reverse
      soma2 = base_digits.chars.map(&:to_i).each_with_index.sum { |n, i| n * pesos2[i] }
      resto2 = soma2 % modulo
      calculado2 = modulo - resto2
      calculado2 = 0 if resto2 == 0 || (modulo == 11 && resto2 == 1)

      return false unless calculado2 == dv2

      # 1º dígito (com o 2º já incluído)
      base_com_dv2 = base_digits + calculado2.to_s
      pesos1 = (2..(base_com_dv2.length + 1)).to_a.reverse
      soma1 = base_com_dv2.chars.map(&:to_i).each_with_index.sum { |n, i| n * pesos1[i] }
      resto1 = soma1 % modulo
      calculado1 = modulo - resto1
      calculado1 = 0 if resto1 == 0 || (modulo == 11 && resto1 == 1)

      calculado1 == dv1
    end

    def generate(length: 8)
      raise ArgumentError, "Tamanho deve ser 8 ou 9" unless [8, 9].include?(length)

      base = Array.new(length - 2) { rand(0..9) }

      modulo = define_modulo(base.join)

      # 2º DV
      pesos2 = (2..(base.length + 1)).to_a.reverse
      soma2 = base.each_with_index.sum { |n, i| n * pesos2[i] }
      resto2 = soma2 % modulo
      dv2 = modulo - resto2
      dv2 = 0 if resto2 == 0 || (modulo == 11 && resto2 == 1)

      # 1º DV
      base_com_dv2 = base + [dv2]
      pesos1 = (2..(base_com_dv2.length + 1)).to_a.reverse
      soma1 = base_com_dv2.each_with_index.sum { |n, i| n * pesos1[i] }
      resto1 = soma1 % modulo
      dv1 = modulo - resto1
      dv1 = 0 if resto1 == 0 || (modulo == 11 && resto1 == 1)

      (base + [dv1, dv2]).join
    end

    private

    def define_modulo(code)
      digito = code.length == 8 ? code[0].to_i : code[1].to_i
      [0, 1, 2, 3, 4, 5, 8].include?(digito) ? 10 : 11
    end
  end
end
