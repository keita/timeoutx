require "benchmark"

require "timeout"
require "timeoutx"

n = 100000
Benchmark.bmbm(10) do |x|
  x.report("Timeout") { 1.upto(n) do ; Timeout.timeout(1){true}; end }
  x.report("TimeoutX") { 1.upto(n) do ; TimeoutX.timeout(1){true}; end }
end
