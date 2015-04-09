#!/bin/env ruby
# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'memory'
require_relative '../answer'

class TestBattle < Minitest::Test
    def setup
        require_relative '../module.battle'
    end

    def test_battle_profession
        mem = BattleMemoryTest.new

        answer = Answer.new('battle', 'profession', 'strstr', 'battle profession', 'theartificiallounge', mem)
        battle = answer.profession
        # puts battle #todo : assert that the messages are correct by exposing their result somehow

        answer = Answer.new('battle', 'profession', 'strstr', 'battle profession rogue', 'theartificiallounge', mem)
        battle = answer.profession
        # puts battle

        answer = Answer.new('battle', 'profession', 'strstr', 'battle profession', 'theartificiallounge', mem)
        battle = answer.profession
        # puts battle

        answer = Answer.new('battle', 'profession', 'strstr', 'battle profession rogue', 'theartificiallounge', mem)
        battle = answer.profession
        # puts battle

        answer = Answer.new('battle', 'profession', 'strstr', 'battle profession potato', 'theartificiallounge', mem)
        battle = answer.profession
      # puts battle
    end

    def test_battle_attack
        mem = BattleMemoryTest.new

        answer = Answer.new('battle', 'attack', 'strstr', 'battle attack potato', 'theartificiallounge', mem)
        battle = answer.attack
        # puts battle # manual validation for now until I expose the battle messages

        answer = Answer.new('battle', 'profession', 'strstr', 'battle profession rogue', 'theartificiallounge', mem)
        battle = answer.profession
        # puts battle

        answer = Answer.new('battle', 'attack', 'strstr', 'battle attack potato', 'theartificiallounge', mem)
        battle = answer.attack
        # puts battle

        answer = Answer.new('battle', 'raise', 'strstr', 'battle raise strstr', 'theartificiallounge', mem)
        battle = answer.raise
        # puts battle

        answer = Answer.new('battle', 'raise', 'strstr', 'battle raise potato', 'theartificiallounge', mem)
        battle = answer.raise
      # puts battle
    end
end

class BattleMemoryTest < Memory
    attr_reader :mem
    def initialize
      @mem = [%w(ludivine potato no),
              ['ludivine', 'profession strstr', 'mage'],
              ['ludivine', 'health strstr', '7'],
              %w(orange seeds yes),
              ['ludivine', 'health potato', '2']]
    end

    def load(_query)
        @mem
    end

    def save(owner, key, value)
        if key == 'profession strstr' then
           @mem[1][2] = value
           return
        end

        if owner == 'ludivine' && key == 'health potato' then
           @mem[4][2] = value
           return
        end
    end
end
