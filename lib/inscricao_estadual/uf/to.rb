module InscricaoEstadual
  module TO
    extend self

    VALID_MIDDLE = %w[01 02 03 99].freeze

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 11
      return false unless VALID_MIDDLE.include?(code[2..3])

      # índices usados: 0, 1, 4, 5, 6, 7, 8, 9
      digits = code.chars.map(&:to_i)
      relevant_digits = [digits[0], digits[1], digits[4], digits[5], digits[6], digits[7], digits[8], digits[9]]
      weights = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = relevant_digits.each_with_index.sum { |digit, i| digit * weights[i] }
      resto = soma % 11
      dv_calc = resto < 2 ? 0 : 11 - resto

      dv_calc == digits[10]
    end

    def generate
      first_two = Array.new(2) { rand(0..9) }
      middle = VALID_MIDDLE.sample.chars.map(&:to_i)
      next_six = Array.new(6) { rand(0..9) }

      base_digits = first_two + middle + next_six
      relevant_digits = [base_digits[0], base_digits[1], base_digits[4], base_digits[5], base_digits[6],
                         base_digits[7], base_digits[8], base_digits[9]]
      weights = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = relevant_digits.each_with_index.sum { |digit, i| digit * weights[i] }
      resto = soma % 11
      dv = resto < 2 ? 0 : 11 - resto

      (base_digits + [dv]).join
    end
  end
end
