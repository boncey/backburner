require File.expand_path('../test_helper', __FILE__)

module NestedDemo
  class TestJobA; include Backburner::Queue; end
  class TestJobB; include Backburner::Queue; end
end

describe "Backburner::Queue module" do
  describe "contains known_queue_classes" do
    it "has all defined known queues" do
      assert_contains Backburner::Worker.known_queue_classes, NestedDemo::TestJobA
      assert_contains Backburner::Worker.known_queue_classes, NestedDemo::TestJobB
    end
  end

  describe "for queue method accessor" do
    it "should return the queue name" do
      assert_equal Backburner.configuration.primary_queue, NestedDemo::TestJobA.queue
    end
  end # queue_name

  describe "for queue assignment method" do
    it "should allow queue name to be assigned" do
      NestedDemo::TestJobB.queue("nested/job")
      assert_equal "nested/job", NestedDemo::TestJobB.queue
    end

    it "should allow lambdas" do
      NestedDemo::TestJobB.queue(lambda { |klass| klass.name })
      assert_equal "NestedDemo::TestJobB", NestedDemo::TestJobB.queue
    end
  end # queue

  describe "for queue_priority assignment method" do
    it "should allow queue priority to be assigned" do
      NestedDemo::TestJobB.queue_priority(1000)
      assert_equal 1000, NestedDemo::TestJobB.queue_priority
    end
  end # queue_priority

  describe "for queue_respond_timeout assignment method" do
    it "should allow queue respond_timeout to be assigned" do
      NestedDemo::TestJobB.queue_respond_timeout(300)
      assert_equal 300, NestedDemo::TestJobB.queue_respond_timeout
    end
  end # queue_respond_timeout

  describe "for queue_max_job_retries assignment method" do
    it "should allow queue max_job_retries to be assigned" do
      NestedDemo::TestJobB.queue_max_job_retries(5)
      assert_equal 5, NestedDemo::TestJobB.queue_max_job_retries
    end
  end # queue_max_job_retries

  describe "for queue_retry_delay assignment method" do
    it "should allow queue retry_delay to be assigned" do
      NestedDemo::TestJobB.queue_retry_delay(300)
      assert_equal 300, NestedDemo::TestJobB.queue_retry_delay
    end
  end # queue_retry_delay

  describe "for queue_retry_delay_proc assignment method" do
    it "should allow queue retry_delay_proc to be assigned" do
      retry_delay_proc = lambda { |x, y| x - y }
      NestedDemo::TestJobB.queue_retry_delay_proc(retry_delay_proc)
      assert_equal retry_delay_proc.call(2, 1), NestedDemo::TestJobB.queue_retry_delay_proc.call(2, 1)
    end
  end # queue_retry_delay_proc
end # Backburner::Queue
