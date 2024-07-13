def dec2glag(input_number, use_titlo=False):
    if not 1 <= input_number <= 5999:
         raise ValueError("The number must be from 1 to 5999")
    glagolitic_symbols = {
        1000: "ⱍⱎⱏⱑⱓ",
        100: "ⱃⱄⱅⱆⱇⱈⱉⱋⱌ",
        10: "ⰺⰻⰼⰽⰾⰿⱀⱁⱂ",
        1: "ⰰⰱⰲⰳⰴⰵⰶⰷⰸ"
    }
    result = ""
    
    for divisor, symbols in glagolitic_symbols.items():
        quotient, input_number = divmod(input_number, divisor)
        if quotient > 0:
            if divisor == 10 and 1 <= quotient <= 9:
                tens = symbols[quotient - 1]
                ones = glagolitic_symbols[1][input_number - 1] if input_number > 0 else ""
                if 11 <= (quotient * 10 + input_number) <= 19:
                    result += ones + tens
                else:
                    result += tens + ones
                break
            else:
                result += symbols[quotient - 1]
    
    if use_titlo:
        titlo = "҃"
        if len(result) == 1:
            result = result + titlo
        else:
            result = result[:-1] + titlo + result[-1]
    
    return result

use_titlo = True
#use_titlo = False

for i in range(1, 6000):
    print(f"{i}; {dec2glag(i, use_titlo=use_titlo)}")

print(f"1; {dec2glag(1, use_titlo=use_titlo)}")  # Units
print(f"11; {dec2glag(11, use_titlo=use_titlo)}") # Tens
print(f"111; {dec2glag(111, use_titlo=use_titlo)}") # Hundreds
print(f"1111; {dec2glag(1111, use_titlo=use_titlo)}") # Thousands

print(f"1; {dec2glag(1, use_titlo=False)}")  # Units
print(f"11; {dec2glag(11, use_titlo=False)}") # Tens
print(f"111; {dec2glag(111, use_titlo=False)}") # Hundreds
print(f"1111; {dec2glag(1111, use_titlo=False)}") # Thousands
