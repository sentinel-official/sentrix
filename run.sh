#!/bin/sh
OPTION="${1}"

get_server_name() {

  echo -n "Please enter password for creating new wallet: "
  read PASSWORD

  if [ ${#PASSWORD} -le 0 ]; then
                echo "Password length must be greater than zero."
                continue
  fi
               SERVERNAME=$(python dnsClient.py ${PASSWORD})
               echo -n  $SERVERNAME
  if [ ${#SERVRNAME} -eq 0 ]; then
      echo "SERVER ERROR"
      exit 1
  fi
}

generate_synapse_file() {
	local filepath="${1}"
        source /synapse/bin/activate
	python -m synapse.app.homeserver \
	       -c "${filepath}" \
	       --generate-config \
	       --report-stats no \
	       -H ${SERVERNAME}
}

case $OPTION in
        "start")
                 get_server_name
                 if [ ${#SERVERNAME} -eq 0 ]; then
                   echo "REQUIRE A NAME FOR MATRIX HOMESERVER NAME"
                   continue
                 else
                   echo "Generating config file"
                   generate_synapse_file /root/sentrix/synapse/homeserver.yaml
                 fi
                 ;;
              *)
                 echo "unknown"
                 ;;

esac
