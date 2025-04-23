module InscricaoEstadual
  module RR
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 9
      return false unless code.start_with?("24")

      base = code[0..7].chars.map(&:to_i)
      dv_real = code[-1].to_i

      soma = base.each_with_index.sum { |digit, i| digit * (i + 1) }
      dv_calc = soma % 9

      dv_calc == dv_real
    end

    def generate
      base = [2, 4] + Array.new(6) { rand(0..9) }

      soma = base.each_with_index.sum { |digit, i| digit * (i + 1) }
      dv = soma % 9

      (base + [dv]).join
    end
  end
end
