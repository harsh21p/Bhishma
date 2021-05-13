#!/bin/sh

dir=~/Bhishma/Recon/$1


bold="\e[1m"
Underlined="\e[4m"
red="\e[31m"
orange="\e[33m"
white="\e[37m"
green="\e[32m"
blue="\e[34m"
end="\e[0m"


  echo -n "$white$bold \n 1] Subdomain enumeration \n 2] QuikXss \n 3] Dirsearch \n 4] All in one \n 5] Clear \n 6] Special Dirsearch \n\n Enter chioce : $end"
  read chioce


case $chioce in

  1)
   mkdir -p $dir
   subfinder -silent -d $1 >> $dir/$1_subfinder
   echo "\n$orange$bold[*] Subfinder:$end $(wc -l < $dir/$1_subfinder)"

   assetfinder -subs-only $1 >> $dir/$1_assetfinder
   echo "\n$white$bold[*] Assetfinder:$end $(wc -l < $dir/$1_assetfinder)"

   chaos -silent -d $1 -key f185d435dfd0269d021f461f9c84ccc73e2174a4b2c75c3beb57eefbb5c06021 >> $dir/$1_chaos
   echo "\n$green$bold[*] Chaos:$end $(wc -l < $dir/$1_chaos)"

   python3 ~/Bhishma/src/crtsh/crtsh.py -d $1 -r >> $dir/$1_subs >> $dir/$1_crt
   echo "\n$orange$bold[*] Crt:$end $(wc -l < $dir/$1_crt)"

   cat $dir/$1_* | sort -u >> $dir/$1_sorted_subs
   echo "\n$white$bold[*] Sorted:$end $(wc -l < $dir/$1_sorted_subs)"

   #cat $dir/$1_sorted_subs

   httpx -silent -l $dir/$1_sorted_subs -mc 200 302 | sort -u >> $dir/d_resolved
   echo "\n$green$bold[*] Resolved:$end $(wc -l < $dir/d_resolved)"

   #grep -oP 'http?://\K\S+' $dir/d_resolved >> $dir/resolved
   awk -F'^http[s]?://' '{print $2}' $dir/d_resolved > $dir/resolved
    

   rm -rf ~/Bhishma/Recon/$1/$1_*

    ;;

  2)
    mkdir -p ~/Bhishma/Resultxss/$1
    cd ~/Bhishma/HACK/SETUP/QuickXSS/
    ./QuickXSS.sh -d $1 -o ~/Bhishma/Resultxss/$1/$1_result
    cd ~
    #rm -rf ~/Bhishma/HACK/SETUP/QuickXSS/results/*
    cat ~/Bhishma/Resultxss/$1/$1_result | awk '{print $3}' | sort -u -o ~/Bhishma/Resultxss/$1/result

    rm -rf ~/Bhishma/Resultxss/$1/$1_*

    ;;

  3)
    mkdir -p ~/Bhishma/Dirsearch/$1
    
    cd ~/Bhishma/Dirsearch/$1

    python3 ~/Bhishma/HACK/SETUP/dirsearch-master/dirsearch.py -l ~/Bhishma/$2 -w ~/Bhishma/HACK/SETUP/dirsearch-master/GOV.in/PHPINFOEXT.txt -i 200 302 --full-url --simple-report=phpinfopage.txt
    python3 ~/Bhishma/HACK/SETUP/dirsearch-master/dirsearch.py -l ~/Bhishma/$2 -w ~/Bhishma/HACK/SETUP/dirsearch-master/GOV.in/WPJSONEXT.txt -i 200 302 --full-url --simple-report=wpjsonpage.txt
    python3 ~/Bhishma/HACK/SETUP/dirsearch-master/dirsearch.py -l ~/Bhishma/$2 -w ~/Bhishma/HACK/SETUP/dirsearch-master/GOV.in/LOGINEXT.txt -i 200 302 --full-url --simple-report=loginpage.txt
    cd ~
    ;;

  6)
    mkdir -p ~/Bhishma/Dirsearch/$1
    
    cd ~/Bhishma/Dirsearch/$1

    python3 ~/Bhishma/HACK/SETUP/dirsearch-master/dirsearch.py -l ~/Bhishma/$2 -w ~/Bhishma/HACK/SETUP/dirsearch-master/GOV.in/GodFuzz.txt -i 200 302 --full-url --simple-report=wordpress.txt
    python3 ~/Bhishma/HACK/SETUP/dirsearch-master/dirsearch.py -l ~/Bhishma/$2 -i 200 302 --full-url --simple-report=all.txt
    cd ~
    ;;

  4)
   mkdir -p $dir
   subfinder -silent -d $1 >> $dir/$1_subfinder
   echo "\n$orange$bold[*] Subfinder:$end $(wc -l < $dir/$1_subfinder)"

   assetfinder -subs-only $1 >> $dir/$1_assetfinder
   echo "\n$white$bold[*] Assetfinder:$end $(wc -l < $dir/$1_assetfinder)"

   chaos -silent -d $1 -key f185d435dfd0269d021f461f9c84ccc73e2174a4b2c75c3beb57eefbb5c06021 >> $dir/$1_chaos
   echo "\n$green$bold[*] Chaos:$end $(wc -l < $dir/$1_chaos)"

   python3 ~/Bhishma/src/crtsh/crtsh.py -d $1 -r >> $dir/$1_subs >> $dir/$1_crt
   echo "\n$orange$bold[*] Crt:$end $(wc -l < $dir/$1_crt)"

   cat $dir/$1_* | sort -u >> $dir/$1_sorted_subs
   echo "\n$white$bold[*] Sorted:$end $(wc -l < $dir/$1_sorted_subs)"


   httpx -silent -l $dir/$1_sorted_subs -mc 200 302 | sort -u >> $dir/d_resolved
   echo "\n$green$bold[*] Resolved:$end $(wc -l < $dir/d_resolved)"

   #grep -oP 'http?://\K\S+' $dir/d_resolved >> $dir/resolved
   awk -F'^http[s]?://' '{print $2}' $dir/d_resolved > $dir/resolved
    

   rm -rf ~/Bhishma/Recon/$1/$1_*
   echo -n "unknown"

   mkdir -p ~/Bhishma/Resultxss/$1

   for item in $(cat $dir/resolved)
   do
      cd ~/Bhishma/HACK/SETUP/QuickXSS/
      ./QuickXSS.sh -d $item -o ~/Bhishma/Resultxss/$1/$1_result
      cd ~
    done

    #rm -rf ~/Bhishma/HACK/SETUP/QuickXSS/results/*

    cat ~/Bhishma/Resultxss/$1/$1_result | awk '{print $3}' | sort -u -o ~/Bhishma/Resultxss/$1/result

    rm -rf ~/Bhishma/Resultxss/$1/$1_*

    mkdir -p ~/Bhishma/Dirsearch/$1
    
    cd ~/Bhishma/Dirsearch/$1/

    python3 ~/Bhishma/HACK/SETUP/dirsearch-master/dirsearch.py -l ~/Bhishma/Recon/$1/d_resolved -w ~/Bhishma/HACK/SETUP/dirsearch-master/GOV.in/PHPINFOEXT.txt -i 200 302 --full-url --simple-report=phpinfopage.txt
    python3 ~/Bhishma/HACK/SETUP/dirsearch-master/dirsearch.py -l ~/Bhishma/Recon/$1/d_resolved -w ~/Bhishma/HACK/SETUP/dirsearch-master/GOV.in/WPJSONEXT.txt -i 200 302 --full-url --simple-report=wpjsonpage.txt
    python3 ~/Bhishma/HACK/SETUP/dirsearch-master/dirsearch.py -l ~/Bhishma/Recon/$1/d_resolved -w ~/Bhishma/HACK/SETUP/dirsearch-master/GOV.in/LOGINEXT.txt -i 200 302 --full-url --simple-report=loginpage.txt
    python3 ~/Bhishma/HACK/SETUP/dirsearch-master/dirsearch.py -l ~/Bhishma/Recon/$1/d_resolved -w ~/Bhishma/HACK/SETUP/dirsearch-master/GOV.in/GodFuzz.txt -i 200 302 --full-url --simple-report=wordpress.txt
    python3 ~/Bhishma/HACK/SETUP/dirsearch-master/dirsearch.py -l ~/Bhishma/Recon/$1/d_resolved -i 200 302 --full-url --simple-report=all.txt
    cd ~
    ;;

 5)
   rm -rf ~/Bhishma/Recon/*
   rm -rf ~/Bhishma/Dirsearch/*
   rm -rf ~/Bhishma/HACK/SETUP/QuickXSS/results/*
   rm -rf ~/Bhishma/Resultxss/*
   bash ~/Bhishma/Bhishma $2
    ;;
esac

rm -rf $dir/$1_subfinder
rm -rf $dir/$1_assetfinder
rm -rf $dir/$1_chaos
rm -rf $dir/$1_crt
