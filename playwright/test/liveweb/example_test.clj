(ns liveweb.example-test
  (:require [clojure.test :as t :refer [deftest testing]])
  (:import (com.microsoft.playwright Playwright BrowserType$LaunchOptions)
           (com.microsoft.playwright.assertions PlaywrightAssertions)))

(def ^:dynamic *page* nil)
(defonce headless (atom true))

(t/use-fixtures :once
  (fn [tests]
    (with-open [pw (Playwright/create)]
      (let [chromium (.chromium pw)
            options (doto (BrowserType$LaunchOptions.)
                      (.setHeadless @headless))
            browser (.launch chromium options)]
        (with-open [context (.newContext browser)]
          (.setDefaultTimeout context 10000)
          (binding [*page* (.newPage context)]
            (tests)))))))

(defn go [url]
  (.navigate *page* url))

(defn loc [& str]
  (loop [l *page*
         [s & str] str]
    (if-not s
      l
      (recur (.locator l s) str))))

(defmacro => [locs & assertion]
  `(t/is
    (= true
       (try (-> (PlaywrightAssertions/assertThat (loc ~@locs))
                ~@assertion)
            true
            (catch org.opentest4j.AssertionFailedError afe#
              {:actual (.getActual afe#)
               :expected (.getExpected afe#)})))))

(deftest counter
  (go "http://localhost:8080/examples/counter")
  (=> ["div.counter"] (.hasText "0"))
  (-> "button.inc" loc .click)
  (=> ["div.counter"] (.hasText "1"))
  (-> "button.dec" loc .click)
  (-> "button.dec" loc .click)
  (=> ["div.counter"] (.hasText "-1")))

(deftest multi-counter
  (go "http://localhost:8080/examples/multi-counter")
  (=> ["div.counter"] (.hasCount 5))
  (=> ["div.counter" "nth=0"] (.hasText "2"))
  (=> ["div.counter" "nth=4"] (.hasText "32"))
  (-> (loc "div.counterComponent" "nth=0" "button.inc") .click)
  (=> ["div.counter" "nth=0"] (.hasText "3"))
  (-> (loc "input#initialCount") (.type "42"))
  (-> (loc "button" "text=Add new counter") .click)
  (=> ["div.counter"] (.hasCount 6))
  (=> ["div.counter" "nth=5"] (.hasText "42")))
