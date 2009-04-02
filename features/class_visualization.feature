Feature: Ruby class visualization

  In order to improve my understand of a ruby class
  As a ruby developer
  I want to see a diagram of how class methods and variables collaborate

  Scenario Outline: Example ruby file
    Given a sample ruby file, <group>/<example>.rb
    When I execute "rubyviz <example>.rb"
    Then the expected output file "<example>.rb.png" should be produced
    
  Examples:
    | group              | example             |
    | methods            | example1            |
    | methods            | example2            |
    | methods            | modules             |
    | methods            | requires            |
    | methods            | bare_method         |
    | instance_variables | example3            |
    | instance_variables | example4            |
    | instance_variables | example5            |
    | instance_variables | example6            |
    | instance_variables | method_rescue       |
    | instance_variables | method_rescue_block |
    | instance_variables | variable_call       |
    | .                  | ticgit-cli          |
