#!/bin/bash
echo -e "Assuming you know what you are doing and satellites are all in position...."

read -p 'Do you want to clone the Intellipay repository? : ' config
if [ $config == "y" ]; then
    echo "Cloning Intellipay repo..."
    git clone git@bitbucket.org:intellicp2/pay.git
    #git clone git@bitbucket.org:intellicp2/cryptopp.git
    #git clone git@bitbucket.org:intellicp2/eventdeploy.git
    #git clone git@bitbucket.org:intellicp2/eventsmaster.git
    git clone git@bitbucket.org:intellicp2/intellipaybuild.git
    #git clone git@bitbucket.org:intellicp2/libarchive.git
    #git clone git@bitbucket.org:intellicp2/log4cplus.git
    #git clone git@bitbucket.org:intellicp2/optional.git
    #git clone git@bitbucket.org:intellicp2/eet.git
    echo "Downloading Intellipay repository complete..."
fi

read -p 'Do you want to configure the repository? : ' config
if [ $config == "y" ]; then
    echo "Configuring server.config file..."
    if [ ! -f ~/Documents/repobuilder/patches/server.config ]; then
        echo "Server configuration template file not found! ((~/Documents/repobuilder/patches/server.config))"
     else
        cp -f ~/Documents/repobuilder/patches/server.config ./pay/server/resources/configs/server.config
    fi
    
    echo "Configuring CustomerWeb..."
    cd ./pay/server/src/ICLS.CustomerWeb/ && npm install && bower install && cd -
    echo "Configuring ManagementWeb..."
    cd ./pay/server/src/ICLS.ManagementWeb/ && npm install && sencha app build development && cd -
fi
echo -e "Done! \n Now enjoy your coffee..."
echo -e "                      (                           \n                        )     (                   \n                 ___...(-------)-....___          \n             .-\"\"       )    (          \"\"-.  \n       .-\"\`\`\"|-._             )         _.-|  \n      /  .--.|   \`\"\"---...........---\"\"\`   |\n     /  /    |                             |      \n     |  |    |                             |      \n      \\  \\   |                             |    \n       \`\\ \`\\ |                             |  \n         \`\\ \`|                             |   \n         _/ /\\                             /     \n        (__/  \\                           /      \n               \\                         /       \n                \\                       /        \n                 \`-.__             __.-\"        \n                    ) \"\"---...---\"\" (         \n                    \`\"--...___...--\"\`         \n"                                                  
echo "Press any key to continue..."
read