* Ruby 2.6.3

* Gems
  * json
  * active_support

* Execution
  * ruby main.rb <input args>
  * Ex
    - Input:
      $ ruby main.rb '{"grid": {"length": 5, "breadth":  5},"infectedCells": [{"x":  1, "y":  1}, {"x":  2, "y":  3}],"persons": [{"initialPosition": "1 0 N", "movement": "FFRFFRF"},{"initialPosition": "1 3 S", "movement": "LFFLFRFRFF"}]}'
      - Output:
        [["0", "0", "0", "X", "X"],
         ["0", "0", "X", "X", "X"],
         ["0", "X", "X", "X", "X"],
         ["0", "X", "0", "X", "0"],
         ["0", "0", "0", "0", "0"]]

    - Input with medical centres
      $ ruby main.rb '{"grid": {"length": 5, "breadth":  5},"infectedCells": [{"x":  1, "y":  1}, {"x":  2, "y":  3}],"medicalCentres": [{"x":  3, "y":  1}],"persons": [{"initialPosition": "1 0 N", "movement": "FFRFFLF", "type": "citizen"},{"initialPosition": "1 3 S", "movement": "LFFRFFRFFLF", "type": "citizen"}]}'
      - Output:
        [["0", "0", "0", "0", "0"],
         ["0", "0", "X", "X", "0"],
         ["0", "X", "X", "I", "0"],
         ["0", "X", "I", "M", "I"],
         ["0", "X", "0", "I", "0"]]

    - Input with medics
      $ ruby main.rb '{"grid": {"length": 5, "breadth":  5},"infectedCells": [{"x":  1, "y":  1}, {"x":  2, "y":  3}],"persons": [{"initialPosition": "1 0 N", "movement": "FFRFFRF", "type": "citizen"},{"initialPosition": "1 3 S", "movement": "LFFLFRFRFF", "type": "citizen"},{"initialPosition": "0 2 N", "movement": "FRFRFLFF", "type": "medic"}]}'
      - Output:
        [["0", "0", "0", "X", "X"],
         ["0", "0", "X", "X", "X"],
         ["0", "0", "0", "0", "X"],
         ["0", "X", "0", "X", "0"],
         ["0", "0", "0", "0", "0"]]


# infected-grid-traversal
