package com.example.whatsapp_status_opener

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.provider.DocumentsContract
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.content.ContentResolver
import androidx.documentfile.provider.DocumentFile
import android.content.Context







class WhatsappStatusOpenerPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware,PluginRegistry.ActivityResultListener   {
    private lateinit var channel: MethodChannel
    private var activityBinding: ActivityPluginBinding? = null
    private lateinit var result: MethodChannel.Result


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "whatsapp_status_opener")
        channel.setMethodCallHandler(this)
       
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
         this.result = result
        if (call.method == "openStatusesFolder") {
            val customPath = call.argument<String>("customPath")
            openWhatsAppStatusFolder(customPath)
        }else if (call.method == "getWhatsAppStatusFolder") {
            val treeUri = call.argument<String>("treeUri")
            getWhatsAppStatusFolder(treeUri)
                
        } else {
            result.notImplemented()
        }
    }

    private fun openWhatsAppStatusFolder(customPath: String?) {
        
        if (customPath != null) {
           val i = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE)    
           val initial = Uri.parse(customPath)
           i.putExtra("android.provider.extra.INITIAL_URI", initial)
           activityBinding?.activity?.startActivityForResult(i, 123)
        }
        
    }

    private fun getWhatsAppStatusFolder(treeUri: String?) {
        
        if (treeUri != null) {
           val context: Context = activityBinding?.activity?.applicationContext ?: return
           val emptyStringList = mutableListOf<String>()
           val fileDoc: DocumentFile? = DocumentFile.fromTreeUri(context, Uri.parse(treeUri))
           for (file in fileDoc?.listFiles() ?: emptyArray<DocumentFile>()) {
                        emptyStringList.add(file.getUri().toString())
                    }

            result.success(emptyStringList.toString())
            

        }
        
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        // Not used in this example
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityBinding = binding
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activityBinding = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (requestCode == 123) {
      if (resultCode == Activity.RESULT_OK) {
        if (data != null) {
          val treeUri: Uri? = data?.data
          

          if (treeUri != null) {
                    
                    activityBinding?.activity?.contentResolver?.takePersistableUriPermission(treeUri, Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION)  
                    result.success(treeUri.toString())
                    return true 
                    
                }
            
          
        }
      }
    }
    result.success(null)
    return false
  }


}
