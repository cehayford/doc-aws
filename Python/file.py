def solving_for_prime_num(init, final):
    prime = []
    for num in range(init, final+1):
        if num > 1:
            for i in range(2, int(num ** 0.5) + 1):
                if num % i == 0:
                    break
            else:
                prime.append(num)
    # Write the results to results.txt
    with open("results.txt", "w") as f:
        f.write("Prime numbers list: " + str(prime) + "\n")
    print("Prime numbers list written to results.txt.")


solving_for_prime_num(1, 250)