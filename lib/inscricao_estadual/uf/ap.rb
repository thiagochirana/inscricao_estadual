module InscricaoEstadual
  module AP
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 9
      return false unless code.start_with?("03")

      base = code[0..7].to_i
      dv_real = code[-1].to_i

      p, d = parametros_por_faixa(base)

      digits = code[0..7].chars.map(&:to_i)
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]
      soma = p + digits.each_with_index.sum { |n, i| n * pesos[i] }

      resto = soma % 11
      dv_calc = case resto
                when 10 then 0
                when 11 then d
                else 11 - resto
                end

      dv_calc == dv_real
    end

    def generate
      loop do
        empresa = rand(1..999_999).to_s.rjust(6, "0")
        body = "03#{empresa}"
        base = body.to_i
        p, d = parametros_por_faixa(base)

        digits = body.chars.map(&:to_i)
        pesos = [9, 8, 7, 6, 5, 4, 3, 2]
        soma = p + digits.each_with_index.sum { |n, i| n * pesos[i] }

        resto = soma % 11
        dv = case resto
             when 10 then 0
             when 11 then d
             else 11 - resto
             end

        return body + dv.to_s
      end
    end

    private

    def parametros_por_faixa(valor)
      case valor
      when 3_000_001..3_017_000
        [5, 0]
      when 3_017_001..3_019_022
        [9, 1]
      else
        [0, 0]
      end
    end
  end
end
