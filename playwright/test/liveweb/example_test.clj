(ns liveweb.example-test
  (:require [clojure.test :as t :refer [deftest testing]])
  (:import (com.microsoft.playwright Playwright Browser Page)
           (com.microsoft.playwright.assertions PlaywrightAssertions)))

(def ^:dynamic *page* nil)

(t/use-fixtures :once
  (fn [tests]
    (with-open [pw (Playwright/create)]
      (let [browser (-> pw .chromium .launch)]
        (binding [*page* (.newPage browser)]
          (tests))))))

(defn go [url]
  (.navigate *page* url))

(defn loc [str]
  (.locator *page* str))

(defmacro => [loc & assertion]
  `(t/is
    (= true
       (try (-> (PlaywrightAssertions/assertThat (.locator *page* ~loc))
                ~@assertion)
            true
            (catch org.opentest4j.AssertionFailedError afe#
              {:actual (.getActual afe#)
               :expected (.getExpected afe#)})))))

(deftest counter
  (go "http://localhost:8080/examples/counter")
  (=> "div.counter" (.hasText "0"))
  (-> "button.inc" loc .click)
  (=> "div.counter" (.hasText "1"))
  (-> "button.dec" loc .click)
  (-> "button.dec" loc .click)
  (=> "div.counter" (.hasText "-1")))
