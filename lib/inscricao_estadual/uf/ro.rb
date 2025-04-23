module InscricaoEstadual
  module RO
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless [6, 14].include?(code.length)

      if code.length == 6
        base = code[0..4].chars.map(&:to_i)
        dv_real = code[-1].to_i
        pesos = [6, 5, 4, 3, 2]
      else
        base = code[0..12].chars.map(&:to_i)
        dv_real = code[-1].to_i
        pesos = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
      end

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv_calc = 11 - resto
      dv_calc = dv_calc >= 10 ? dv_calc - 10 : dv_calc

      dv_calc == dv_real
    end

    def generate(format: :new)
      case format
      when :old
        base = Array.new(5) { rand(0..9) }
        pesos = [6, 5, 4, 3, 2]
      when :new
        base = Array.new(13) { rand(0..9) }
        pesos = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
      else
        raise ArgumentError, "format must be :old or :new"
      end

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv = 11 - resto
      dv = dv >= 10 ? dv - 10 : dv

      (base + [dv]).join
    end
  end
end
