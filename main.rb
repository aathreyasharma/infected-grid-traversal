require 'active_support/core_ext/hash/indifferent_access'
require 'json'
require_relative 'grid'
require_relative 'person'
require_relative 'node'

$directions = ActiveSupport::HashWithIndifferentAccess.new({
  w: {l: :s, r: :n},
  e: {l: :n, r: :s},
  n: {l: :w, r: :e},
  s: {l: :e, r: :w}
}).freeze


def main
  json_string = ARGV[0]
  input = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(json_string))
  $grid = Grid.new(input[:grid], input[:infectedCells], input[:medicalCentres])
  peeps = input[:persons].inject([]){ |arr, params| arr << Person.new(params) }
  peeps.map(&:travel)
  pp $grid.show
end

main
