module InscricaoEstadual
  module CE
    module_function

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 9

      base = code[0..7].chars.map(&:to_i)
      dv = code[-1].to_i
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      calculado = 11 - resto
      calculado = 0 if calculado >= 10

      calculado == dv
    end

    def generate
      base = Array.new(8) { rand(0..9) }
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv = 11 - resto
      dv = 0 if dv >= 10

      (base + [dv]).join
    end
  end
end
