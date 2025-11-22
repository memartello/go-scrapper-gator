package config

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
)


const configFileName = "/.gatorconfig.json"

type ConfigValue struct {
	DB_URL       string `json:"db_url"`
	Current_User string `json:"current_user_name"`
}

func GetConfigPath() string {
	path, err := os.UserHomeDir()
	if err != nil {
		fmt.Println("Error geting user home dir")
		os.Exit(1)
	}
	return path + configFileName
}

func Read() (*ConfigValue, error) {

	var config ConfigValue
	content, err := os.ReadFile(GetConfigPath())
	if err != nil {
		return nil, err
	}

	if err := json.Unmarshal(content,&config); err != nil {
		return nil, err
	}


	return &config, nil
}

func (cfg *ConfigValue) SetUser(username string) error {
	cfg.Current_User = username
	return Write(*cfg)
}


func Write(cfg ConfigValue) error {
	jsonData, err := json.Marshal(cfg)
	if err != nil {
		log.Fatal(err)
	}
	os.WriteFile(GetConfigPath(), jsonData, 0644)
	return nil
}
