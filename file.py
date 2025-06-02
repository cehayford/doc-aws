def solving_for_prime_num(init, final):
    prime = []
    for num in range(init, final+1):
        if num > 1:
            for i in range(2, int(num ** 0.5) + 1):
                if num % i == 0:
                    break
            else:
                # print(f"{num} is a prime number")
                prime.append(num)
    print("Prime numbers list:", prime)


solving_for_prime_num(1, 250)