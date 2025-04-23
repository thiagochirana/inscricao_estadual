module InscricaoEstadual
  module PA
    extend self

    PA_VALID_PREFIXES = %w[15 75 76 77 78 79].freeze

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 9
      return false unless PA_VALID_PREFIXES.include?(code[0..1])

      base = code[0..7].chars.map(&:to_i)
      dv = code[-1].to_i
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv_calc = resto <= 1 ? 0 : 11 - resto

      dv_calc == dv
    end

    def generate
      prefix = PA_VALID_PREFIXES.sample.chars.map(&:to_i)
      base = prefix + Array.new(6) { rand(0..9) }
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv = resto <= 1 ? 0 : 11 - resto

      (base + [dv]).join
    end
  end
end
