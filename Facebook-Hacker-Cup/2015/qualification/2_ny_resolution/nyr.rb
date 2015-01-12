input = IO.readlines('input.txt')
tt = input[0].to_i
i = 1
t = 1

while t<=tt
    goals = input[i].split(' ').map(&:to_i)
    i+=1

    nn = input[i].to_i
    i+=1

    foods = []
    n = 1
    while n<=nn
        foods.push(input[i].split(' ').map(&:to_i))
        i+=1
        n +=1
    end

    out = "no"

    p = 0
    while p < 2**nn
        sum = Array.new(goals.length, 0)

        foods.each_with_index do |f, ix|
            if p&(2**ix)>0
                sum = sum.zip(f).map { |pair| pair.reduce(&:+) }
            end
        end

        if sum.join(' ') == goals.join(' ')
            out = "yes"
            break
        end

        p +=1 
    end

    puts "Case #{t}: #{out}"

    t+=1
end

