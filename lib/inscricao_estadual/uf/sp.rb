module InscricaoEstadual
  module SP
    extend self

    def validate(code)
      code = code.to_s.strip.upcase.gsub(/[^0-9P]/, "")
      return validate_rural(code) if code.start_with?("P")

      validate_general(code)
    end

    def validate_general(code)
      return false unless code.length == 12

      digits = code.chars.map(&:to_i)

      dv1 = calculate_dv1(digits[0..7])
      dv2 = calculate_dv2(digits[0..10])

      digits[8] == dv1 && digits[11] == dv2
    end

    def validate_rural(code)
      return false unless code.length == 13 && code.start_with?("P0")

      digits = code[1..8].chars.map(&:to_i) # P ignorado
      dv_real = code[9].to_i

      dv_calc = calculate_dv1(digits)

      dv_calc == dv_real
    end

    def generate(type: :general)
      if type == :rural
        base = [0] + Array.new(7) { rand(0..9) }
        dv = calculate_dv1(base)
        "P" + base.join + dv.to_s + "000"
      else
        base = Array.new(8) { rand(0..9) }
        dv1 = calculate_dv1(base)
        partial = base + [dv1] + Array.new(2) { rand(0..9) }
        dv2 = calculate_dv2(partial)
        (partial + [dv2]).join
      end
    end

    private

    def calculate_dv1(digits)
      pesos = [1, 3, 4, 5, 6, 7, 8, 10]
      soma = digits.each_with_index.sum { |d, i| d * pesos[i] }
      soma % 11 % 10
    end

    def calculate_dv2(digits)
      pesos = [3, 2, 10, 9, 8, 7, 6, 5, 4, 3, 2]
      soma = digits.each_with_index.sum { |d, i| d * pesos[i] }
      soma % 11 % 10
    end
  end
end
