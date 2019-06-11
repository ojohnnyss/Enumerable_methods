module Enumerable
	def my_each
	  for i in self
	    yield(i)
	  end
	end
	
	def my_each_with_index
	  for i in 0..self.length-1
            yield(self[i], i)
	  end
	end
	
	def my_select
	  output = self.class.new
	  self.my_each do |x, y = nil|
	    if yield(x) == true
              if output.class == Hash
		output[x] = y
	      else
		output.push(x)
	      end
	    end
	  end
	  return output
	end
	
	def my_all
	  out = true
	  self.my_each do |x|
	    if yield(x) == false
	      out = false
	      break
	    end
	  end
	  return out
	end
	
	def my_any?
	  out = false
	  self.my_each do |x|
	    if yield(x) == true
	      out = true
	      break
	    end
	  end
	  return out
	end

	def my_none?
	  out = false
	  self.my_each do |x|
            if yield(x) == true
	      out = false
	      break
	    end
	  end
	  return out
	end

	def my_count(search = nil)
	  count = 0
	  if block_given?
	    self.my_each do |x|
	      if yield(x) == true
		count += 1
	      end
	    end
	  elsif search == nil
	    count = self.length
	  else
	    self.my_each do |x, y = nil|
	      if x == search
		count += 1
	      end 
	      if y == search
		count += 1
	      end
	    end
	  end
	  return count
	end

	def my_map(proc = nil)
	  output = []
	  self.my_each do |x|
	    if proc && block_given?
	      output.push(yield(proc.call(x)))
	  elsif proc
	    output.push(proc.call(x))
	  else
	    puts "error, block will not run without proc"
	    break
	  end
	end
	return output
	end

	def my_inject(num = 0)
	  output = num
	  self.my_each do |x|
	    output = yield(output, x)
	  end
	  return output
	end
end

def multiply_els(arr)
	puts arr.my_inject(1) {| prod, ele| prod * ele }
end
		    
a = [3,4,5]
multiply_els(a) # 60
