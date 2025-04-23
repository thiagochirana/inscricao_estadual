module InscricaoEstadual
  module MS
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 9
      return false unless code.start_with?("28", "50")

      base = code[0..7].chars.map(&:to_i)
      dv = code[-1].to_i
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv_calc = if resto == 0
                  0
                else
                  t = 11 - resto
                  t > 9 ? 0 : t
                end

      dv_calc == dv
    end

    def generate
      prefix = [["28"], ["50"]].sample.flatten
      base = prefix + Array.new(6) { rand(0..9) }
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv = if resto == 0
             0
           else
             t = 11 - resto
             t > 9 ? 0 : t
           end

      (base + [dv]).join
    end
  end
end
