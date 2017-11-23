// Copyright (c) 2017 BVK Chaitanya
//
// This file retrieves USD values of different crypto currencies and
// prints the total balance.
//
// USAGE
//
// $ go run crypto-currency.go --btc 10 --eth 20 --bch 30 --zec 40
//
// NOTES
//
// Current value of crypto-currencies are retrieved from
// https://api.coinmarketcap.com website.

package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"net/http"
	"time"
)

var numBTC = flag.Float64("btc", 0.0, "Count of Bitcoins.")
var numETH = flag.Float64("eth", 0.0, "Count of Ethereum.")
var numBCH = flag.Float64("bch", 0.0, "Count of Bitcoin Cash.")
var numZEC = flag.Float64("zec", 0.0, "Count of Zcash.")

func main() {
	flag.Parse()

	tport := &http.Transport{
		MaxIdleConns:       10,
		IdleConnTimeout:    30 * time.Second,
		DisableCompression: true,
	}
	client := &http.Client{Transport: tport}

	resp, errGet := client.Get("https://api.coinmarketcap.com/v1/ticker/?convert=USD")
	if errGet != nil {
		log.Fatalf("could not query api.coinmarketcap.com: %v", errGet)
	}

	type Ticker struct {
		ID    string      `json:"id"`
		Price json.Number `json:"price_usd"`
	}
	var data []Ticker

	decoder := json.NewDecoder(resp.Body)
	if err := decoder.Decode(&data); err != nil {
		log.Fatalf("could not unmarshal api response: %v", err)
	}

	holdingsMap := map[string]float64{
		"bitcoin":      *numBTC,
		"bitcoin-cash": *numBCH,
		"ethereum":     *numETH,
		"zcash":        *numZEC,
	}

	total := float64(0)
	for _, entry := range data {
		if count, ok := holdingsMap[entry.ID]; ok && count > 0 {
			value, errPrice := entry.Price.Float64()
			if errPrice != nil {
				log.Fatalf("could not price of %s (%s) convert to float64: %v",
					entry.ID, entry.Price, errPrice)
			}
			fmt.Println(entry.ID, count*value)
			total += count * value
		}
	}
	fmt.Println(total)
}
