#!/bin/bash
############################################################################
##                支持根据network选择不同的库文件进行打包                     ##
############################################################################
SDK_Path=''
SDK_TopOn_Path="libs"
SDK_TopOn=("/")
SDK_Admob_Path="network_sdk/admob/"
SDK_Admob=("libs" "extra")
SDK_Facebook_Path="network_sdk/facebook/"
SDK_Facebook=("libs" "extra")
SDK_Inmobi_Path="network_sdk/inmobi/"
SDK_Inmobi=("libs" "extra")
SDK_Flurry_Path="network_sdk/flurry/"
SDK_Flurry=("libs")
SDK_Applovin_Path="network_sdk/applovin/"
SDK_Applovin=("libs")
SDK_Mintegral_china_Path="network_sdk/mintegral_china/"
SDK_Mintegral_china=("libs")
SDK_Mintegral_international_Path="network_sdk/mintegral_international/"
SDK_Mintegral_international=("libs")
SDK_Mopub_Path="network_sdk/mopub/"
SDK_Mopub=("libs")
SDK_GDT_Path="network_sdk/gdt/"
SDK_GDT=("libs" "extra")
SDK_Chartboost_Path="network_sdk/chartboost/"
SDK_Chartboost=("libs" "extra")
SDK_Tapjoy_Path="network_sdk/tapjoy/"
SDK_Tapjoy=("libs" "extra")
SDK_IronSource_Path="network_sdk/ironsource/"
SDK_IronSource=("libs" "extra")
SDK_UnityAds_Path="network_sdk/unityads/"
SDK_UnityAds=("libs")
SDK_Vungle_Path="network_sdk/vungle/"
SDK_Vungle=("libs" "extra")
SDK_Adcolony_Path="network_sdk/adcolony/"
SDK_Adcolony=("libs" "extra")
SDK_TT_Path="network_sdk/toutiao/"
SDK_TT=("libs" "extra")
SDK_Uniplay_Path="network_sdk/uniplay/"
SDK_Uniplay=("libs")
SDK_Oneway_Path="network_sdk/oneway/"
SDK_Oneway=("libs" "extra")
SDK_Mcore_Path="network_sdk/mcore/"
SDK_Mcore=("libs")
SDK_Ksyun_Path="network_sdk/ksyun/"
SDK_Ksyun=("libs")
SDK_Appnext_Path="network_sdk/appnext/"
SDK_Appnext=("libs" "extra")
SDK_Baidu_Path="network_sdk/baidu/"
SDK_Baidu=("libs" "extra")
SDK_Nend_Path="network_sdk/nend/"
SDK_Nend=("libs" "extra")
SDK_Maio_Path="network_sdk/maio/"
SDK_Maio=("libs" "extra")
SDK_Startapp_Path="network_sdk/startapp/"
SDK_Startapp=("libs")
SDK_Superawesome_Path="network_sdk/superawesome/"
SDK_Superawesome=("libs")
SDK_KS_Path="network_sdk/ks/"
SDK_KS=("libs")
SDK_Sigmob_Path="network_sdk/sigmob/"
SDK_Sigmob=("libs")
SDK_Ogury_Path="network_sdk/ogury/"
SDK_Ogury=("libs")


input_nwfirmid_list=$1
input_country=$2
release_folder="release_folder"
release_folder_libs="release_folder/libs"
release_folder_res="release_folder/res"
sdk_release="sdk_release_"
manifest_file_name="AndroidManifest.xml"
manifest_prefix="prefix_manifest_"
manifest_permission_prefix="prefix_manifest_permission_"
manifest_application_prefix="prefix_manifest_application_"
proguard_file="proguard-android.txt"

##根据输入的NetworkFirmId列表进行遍历，选择文件打出压缩包
package_files(){
	nwfirmid_array=(${input_nwfirmid_list//\,/ })
	rm -r ${release_folder}
	rm *.zip
	mkdir ${release_folder}
    mkdir ${release_folder_libs}
    mkdir ${release_folder_res}

	
	for i in "${!SDK_TopOn[@]}"; do
    	# echo "$i=>${SDK_TopOn[i]}"
    	cp -a "${SDK_Path}${SDK_TopOn_Path}${SDK_TopOn[i]}" "${release_folder_libs}"
	done

    ##TODO merge AndroidManifest.xml files

	for i in "${!nwfirmid_array[@]}"; do
    	echo "$i=>${nwfirmid_array[i]}"
    	if [ "${nwfirmid_array[i]}" -eq "1" ];then
    		echo "facebook"
    		for j in "${!SDK_Facebook[@]}"; do
    			cp -a "${SDK_Path}${SDK_Facebook_Path}${SDK_Facebook[j]}/" "${release_folder_libs}"
    		done

            if [ -d "${SDK_Path}${SDK_Facebook_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Facebook_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Facebook_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Facebook_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_Facebook_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Facebook_Path}${manifest_file_name}" 1
            fi

		fi
		if [ "${nwfirmid_array[i]}" -eq "2" ];then
    		echo "admob"
    		for j in "${!SDK_Admob[@]}"; do
    			cp -a "${SDK_Path}${SDK_Admob_Path}${SDK_Admob[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Admob_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Admob_Path}res/" "${release_folder_res}"
            fi
            if [ -f "${SDK_Path}${SDK_Admob_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Admob_Path}${proguard_file}"
            fi
    		
            if [ -f "${SDK_Path}${SDK_Admob_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Admob_Path}${manifest_file_name}" 2
            fi

		fi
		if [ "${nwfirmid_array[i]}" -eq "3" ];then
    		echo "inmobi"
    		for j in "${!SDK_Inmobi[@]}"; do
    			cp -a "${SDK_Path}${SDK_Inmobi_Path}${SDK_Inmobi[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Inmobi_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Inmobi_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Inmobi_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Inmobi_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_Inmobi_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Inmobi_Path}${manifest_file_name}" 3
            fi
    		
		fi
		if [ "${nwfirmid_array[i]}" -eq "4" ];then
    		echo "flurry"
    		for j in "${!SDK_Flurry[@]}"; do
    			cp -a "${SDK_Path}${SDK_Flurry_Path}${SDK_Flurry[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Flurry_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Flurry_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Flurry_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Flurry_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_Flurry_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Flurry_Path}${manifest_file_name}" 4
            fi
    		
		fi
		if [ "${nwfirmid_array[i]}" -eq "5" ];then
    		echo "Applovin"
    		for j in "${!SDK_Applovin[@]}"; do
    			cp -a "${SDK_Path}${SDK_Applovin_Path}${SDK_Applovin[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Applovin_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Applovin_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Applovin_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Applovin_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_Applovin_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Applovin_Path}${manifest_file_name}" 5
            fi
    		
		fi
        #china
		if [ "${nwfirmid_array[i]}" -eq "6" ]  && [ "${input_country}" = "cn" ];then
    		echo "Mintegral_china"
    		for j in "${!SDK_Mintegral_china[@]}"; do
    			cp -a "${SDK_Path}${SDK_Mintegral_china_Path}${SDK_Mintegral_china[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Mintegral_china_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Mintegral_china_Path}res/" "${release_folder_res}"
            fi
    		
            if [ -f "${SDK_Path}${SDK_Mintegral_china_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Mintegral_china_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_Mintegral_china_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Mintegral_china_Path}${manifest_file_name}" 6
            fi
		fi
        #international
        if [ "${nwfirmid_array[i]}" -eq "6" ] && [ "${input_country}" != "cn" ];then
            echo "Mintegral_international"
            for j in "${!SDK_Mintegral_international[@]}"; do
                cp -a "${SDK_Path}${SDK_Mintegral_international_Path}${SDK_Mintegral_international[j]}/" "${release_folder_libs}"
            done
            if [ -d "${SDK_Path}${SDK_Mintegral_international_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Mintegral_international_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Mintegral_international_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Mintegral_international_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_Mintegral_international_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Mintegral_international_Path}${manifest_file_name}" 6
            fi
            
        fi
		if [ "${nwfirmid_array[i]}" -eq "7" ];then
    		echo "Mopub"
    		for j in "${!SDK_Mopub[@]}"; do
    			cp -a "${SDK_Path}${SDK_Mopub_Path}${SDK_Mopub[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Mopub_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Mopub_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Mopub_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Mopub_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Mopub_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Mopub_Path}${manifest_file_name}" 7
            fi
    		
		fi
		if [ "${nwfirmid_array[i]}" -eq "8" ];then
    		echo "GDT"
    		for j in "${!SDK_GDT[@]}"; do
    			cp -a "${SDK_Path}${SDK_GDT_Path}${SDK_GDT[j]}/" "${release_folder_libs}"
    		done
            echo "${SDK_Path}${SDK_GDT_Path}res/"
            if [ -d "${SDK_Path}${SDK_GDT_Path}/res" ]; then
                echo "${SDK_Path}${SDK_GDT_Path}res/"
                cp -a "${SDK_Path}${SDK_GDT_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_GDT_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_GDT_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_GDT_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_GDT_Path}${manifest_file_name}" 8
            fi
    		
		fi
		if [ "${nwfirmid_array[i]}" -eq "9" ];then
    		echo "Chartboost"
    		for j in "${!SDK_Chartboost[@]}"; do
    			cp -a "${SDK_Path}${SDK_Chartboost_Path}${SDK_Chartboost[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Chartboost_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Chartboost_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Chartboost_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Chartboost_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Chartboost_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Chartboost_Path}${manifest_file_name}" 9
            fi
    		
		fi
		if [ "${nwfirmid_array[i]}" -eq "10" ];then
    		echo "Tapjoy"
    		for j in "${!SDK_Tapjoy[@]}"; do
    			cp -a "${SDK_Path}${SDK_Tapjoy_Path}${SDK_Tapjoy[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Tapjoy_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Tapjoy_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Tapjoy_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Tapjoy_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Tapjoy_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Tapjoy_Path}${manifest_file_name}" 10
            fi
    		
		fi
		if [ "${nwfirmid_array[i]}" -eq "11" ];then
    		echo "Ironsource"
    		for j in "${!SDK_IronSource[@]}"; do
    			cp -a "${SDK_Path}${SDK_IronSource_Path}${SDK_IronSource[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_IronSource_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_IronSource_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_IronSource_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_IronSource_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_IronSource_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_IronSource_Path}${manifest_file_name}" 11
            fi
    		
		fi
		if [ "${nwfirmid_array[i]}" -eq "12" ];then
    		echo "UnityAds"
    		for j in "${!SDK_UnityAds[@]}"; do
    			cp -a "${SDK_Path}${SDK_UnityAds_Path}${SDK_UnityAds[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_UnityAds_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_UnityAds_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_UnityAds_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_UnityAds_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_UnityAds_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_UnityAds_Path}${manifest_file_name}" 12
            fi
    		
		fi
		if [ "${nwfirmid_array[i]}" -eq "13" ];then
    		echo "Vungle"
    		for j in "${!SDK_Vungle[@]}"; do
    			cp -a "${SDK_Path}${SDK_Vungle_Path}${SDK_Vungle[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Vungle_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Vungle_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Vungle_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Vungle_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Vungle_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Vungle_Path}${manifest_file_name}" 13
            fi
    		
		fi
		if [ "${nwfirmid_array[i]}" -eq "14" ];then
    		echo "Adcolony"
    		for j in "${!SDK_Adcolony[@]}"; do
    			cp -a "${SDK_Path}${SDK_Adcolony_Path}${SDK_Adcolony[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Adcolony_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Adcolony_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Adcolony_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Adcolony_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Adcolony_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Adcolony_Path}${manifest_file_name}" 14
            fi
    		
		fi
		if [ "${nwfirmid_array[i]}" -eq "15" ];then
    		echo "TouTiao"
    		for j in "${!SDK_TT[@]}"; do
    			cp -a "${SDK_Path}${SDK_TT_Path}${SDK_TT[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_TT_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_TT_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_TT_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_TT_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_TT_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_TT_Path}${manifest_file_name}" 15
            fi
    		
		fi
        if [ "${nwfirmid_array[i]}" -eq "16" ];then
            echo "Oneway"
            for j in "${!SDK_Uniplay_Path[@]}"; do
                cp -a "${SDK_Path}${SDK_Uniplay_Path}${SDK_Uniplay[j]}/" "${release_folder_libs}"
            done
            if [ -d "${SDK_Path}${SDK_Uniplay_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Uniplay_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Uniplay_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Uniplay_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Uniplay_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Uniplay_Path}${manifest_file_name}" 16
            fi
            
        fi
		if [ "${nwfirmid_array[i]}" -eq "17" ];then
    		echo "Oneway"
    		for j in "${!SDK_Oneway[@]}"; do
    			cp -a "${SDK_Path}${SDK_Oneway_Path}${SDK_Oneway[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Oneway_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Oneway_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Oneway_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Oneway_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Oneway_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Oneway_Path}${manifest_file_name}" 17
            fi
    		
		fi
        if [ "${nwfirmid_array[i]}" -eq "18" ];then
            echo "Oneway"
            for j in "${!SDK_Mcore[@]}"; do
                cp -a "${SDK_Path}${SDK_Mcore_Path}${SDK_Mcore[j]}/" "${release_folder_libs}"
            done
            if [ -d "${SDK_Path}${SDK_Mcore_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Mcore_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Mcore_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Mcore_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Mcore_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Mcore_Path}${manifest_file_name}" 18
            fi
            
        fi
        if [ "${nwfirmid_array[i]}" -eq "19" ];then
            echo "Oneway"
            for j in "${!SDK_Ksyun[@]}"; do
                cp -a "${SDK_Path}${SDK_Ksyun_Path}${SDK_Ksyun[j]}/" "${release_folder_libs}"
            done
            if [ -d "${SDK_Path}${SDK_Ksyun_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Ksyun_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Ksyun_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Ksyun_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Ksyun_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Ksyun_Path}${manifest_file_name}" 19
            fi
            
        fi
		# if [ "${nwfirmid_array[i]}" -eq "20" ];then
  #   		echo "Yeahmobi"
  #   		for j in "${!SDK_Yeahmobi[@]}"; do
  #   			cp -a "${SDK_Path}${SDK_Yeahmobi_Path}${SDK_Yeahmobi[j]}" "${release_folder_libs}"
  #   		done
    		
		# fi
		if [ "${nwfirmid_array[i]}" -eq "21" ];then
    		echo "Appnext"
    		for j in "${!SDK_Appnext[@]}"; do
    			cp -a "${SDK_Path}${SDK_Appnext_Path}${SDK_Appnext[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Appnext_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Appnext_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Appnext_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Appnext_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Appnext_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Appnext_Path}${manifest_file_name}" 21
            fi
		fi
		if [ "${nwfirmid_array[i]}" -eq "22" ];then
    		echo "Baidu"
    		for j in "${!SDK_Baidu[@]}"; do
    			cp -a "${SDK_Path}${SDK_Baidu_Path}${SDK_Baidu[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Baidu_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Baidu_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Baidu_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Baidu_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Baidu_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Baidu_Path}${manifest_file_name}" 22
            fi
		fi
		if [ "${nwfirmid_array[i]}" -eq "23" ];then
    		echo "Nend"
    		for j in "${!SDK_Nend[@]}"; do
    			cp -a "${SDK_Path}${SDK_Nend_Path}${SDK_Nend[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Nend_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Nend_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Nend_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Nend_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Nend_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Nend_Path}${manifest_file_name}" 23
            fi


		fi
		if [ "${nwfirmid_array[i]}" -eq "24" ];then
    		echo "Maio"
    		for j in "${!SDK_Maio[@]}"; do
    			cp -a "${SDK_Path}${SDK_Maio_Path}${SDK_Maio[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Maio_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Maio_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Maio_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Maio_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_Maio_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Maio_Path}${manifest_file_name}" 24
            fi

		fi
        if [ "${nwfirmid_array[i]}" -eq "25" ];then
            echo "Maio"
            for j in "${!SDK_Startapp[@]}"; do
                cp -a "${SDK_Path}${SDK_Startapp_Path}${SDK_Startapp[j]}/" "${release_folder_libs}"
            done
            if [ -d "${SDK_Path}${SDK_Startapp_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Startapp_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Startapp_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Startapp_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_Startapp_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Startapp_Path}${manifest_file_name}" 25
            fi

        fi
        if [ "${nwfirmid_array[i]}" -eq "26" ];then
            echo "Maio"
            for j in "${!SDK_Superawesome[@]}"; do
                cp -a "${SDK_Path}${SDK_Superawesome_Path}${SDK_Superawesome[j]}/" "${release_folder_libs}"
            done
            if [ -d "${SDK_Path}${SDK_Superawesome_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Superawesome_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Superawesome_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Superawesome_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_Superawesome_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Superawesome_Path}${manifest_file_name}" 26
            fi

        fi
		if [ "${nwfirmid_array[i]}" -eq "28" ];then
    		echo "KS"
    		for j in "${!SDK_KS[@]}"; do
    			cp -a "${SDK_Path}${SDK_KS_Path}${SDK_KS[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_KS_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_KS_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_KS_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_KS_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_KS_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_KS_Path}${manifest_file_name}" 28
            fi

		fi
		if [ "${nwfirmid_array[i]}" -eq "29" ];then
    		echo "Sigmob"
    		for j in "${!SDK_Sigmob[@]}"; do
    			cp -a "${SDK_Path}${SDK_Sigmob_Path}${SDK_Sigmob[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Sigmob_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Sigmob_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Sigmob_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Sigmob_Path}${proguard_file}"
            fi


            if [ -f "${SDK_Path}${SDK_Sigmob_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Sigmob_Path}${manifest_file_name}" 29
            fi

		fi
		if [ "${nwfirmid_array[i]}" -eq "36" ];then
    		echo "Ogury"
    		for j in "${!SDK_Ogury[@]}"; do
    			cp -a "${SDK_Path}${SDK_Ogury_Path}${SDK_Ogury[j]}/" "${release_folder_libs}"
    		done
            if [ -d "${SDK_Path}${SDK_Ogury_Path}/res" ]; then
                cp -a "${SDK_Path}${SDK_Ogury_Path}res/" "${release_folder_res}"
            fi

            if [ -f "${SDK_Path}${SDK_Ogury_Path}${proguard_file}" ]; then
                merge_proguard "${SDK_Path}${SDK_Ogury_Path}${proguard_file}"
            fi

            if [ -f "${SDK_Path}${SDK_Ogury_Path}${manifest_file_name}" ]; then
                merge_manifest_network "${SDK_Path}${SDK_Ogury_Path}${manifest_file_name}" 36
            fi

		fi
	done
    merge_manifest_all "manifest all"

	current_time=`date "+%Y%m%d%H%M%S"`
	zip -r ${sdk_release}${current_time}.zip ${release_folder}
	echo "${sdk_release}${current_time}.zip"
}

##合并proguard文件
merge_proguard(){
    source_file=$1
    dest_file="${release_folder}/${proguard_file}" 
    # echo "${source_file}" 
    # echo "${release_folder}/${proguard_file}" 
    cat "${source_file}" | awk '{print $0 >> "'${dest_file}'" }'
}



merge_manifest_permission(){
    source_file=$1
    dest_file="${release_folder}/${manifest_permission_prefix}.txt" 
    # echo "${source_file}" 
    # echo "${release_folder}/${proguard_file}" 
    ##需要去重
    cat "${source_file}" | while read line
    do
        optimize_line=`echo "${line}"`
        if cat "${dest_file}" | grep "$optimize_line">/dev/null 
        then
            echo ""
        else
            ##写入去重后结果
            [[ $line =~ "uses-permission" ]] && echo "${line}" >> "${dest_file}" 
        fi
          
    done
}

merge_manifest_application(){
    source_file=$1
    network_type=$1
    dest_file="${release_folder}/${manifest_application_prefix}.txt" 
    # echo "${source_file}" 
    # echo "${release_folder}/${proguard_file}" 
    application_start="1"

    echo "<!-- network type: ${network_type}-->" >> "${dest_file}"

    cat "${source_file}" | while read line
    do
        if [ "${application_start}" -eq "2" ];then
            result=$(echo $line | grep "</application>")
            if [[ "$result" = "" ]]
            then
                echo "${line}" >> "${dest_file}" 
            fi
        fi
        ##进行读写
        [[ $line =~ "<application>" ]] && application_start="2"
        [[ $line =~ "</application>" ]] && application_start="1"

    done
}

merge_manifest_network(){
    source_file=$1
    network_type=$2
    echo "network manifest file: ${source_file}"
    # xml2 < "${source_file}" > "${release_folder}/${manifest_prefix}${network_type}.txt"
    merge_manifest_permission "${source_file}" "${network_type}"
    merge_manifest_application "${source_file}" "${network_type}"
}

merge_manifest_all(){
    echo "save manifest all!!"
    dest_file="${release_folder}/${manifest_file_name}"
    echo "<manifest xmlns:android=\"http://schemas.android.com/apk/res/android\"" >> "${dest_file}"
    echo "    xmlns:tools=\"http://schemas.android.com/tools\"" >> "${dest_file}"
    echo "    package=\"com.anythink.sdk\">" >> "${dest_file}"

    permission_file="${release_folder}/${manifest_permission_prefix}.txt" 

    cat "${permission_file}" | while read line
    do
        echo "    ${line}" >> "${dest_file}" 
        
    done

    echo "    <application>" >> "${dest_file}"

    application_file="${release_folder}/${manifest_application_prefix}.txt" 

    cat "${application_file}" | while read line
    do
        echo "        ${line}" >> "${dest_file}" 
        
    done

    echo "    </application>" >> "${dest_file}"
    echo "</manifest>" >> "${dest_file}"

    rm "${permission_file}"
    rm "${application_file}"

}

ret=$(package_files)
echo "${ret}"