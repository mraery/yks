package com.ykslingo.ykslingo

import android.media.AudioAttributes
import android.media.AudioFormat
import android.media.AudioTrack
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.concurrent.thread
import kotlin.math.PI
import kotlin.math.exp
import kotlin.math.sin

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.ykslingo.ykslingo/audio"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "playCorrect" -> {
                    thread { playToneSequence(listOf(523.25 to 0.08, 659.25 to 0.08, 783.99 to 0.08, 1046.50 to 0.22)) }
                    result.success(null)
                }
                "playIncorrect" -> {
                    thread { playToneSequence(listOf(440.0 to 0.12, 311.13 to 0.22)) }
                    result.success(null)
                }
                "playLessonPass" -> {
                    thread { playToneSequence(listOf(523.25 to 0.09, 659.25 to 0.09, 783.99 to 0.09, 1046.50 to 0.12, 1318.51 to 0.35)) }
                    result.success(null)
                }
                "playLessonFail" -> {
                    thread { playToneSequence(listOf(370.0 to 0.14, 311.13 to 0.14, 261.63 to 0.30)) }
                    result.success(null)
                }
                "playFlip" -> {
                    thread { playToneSequence(listOf(900.0 to 0.03)) }
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun playToneSequence(tones: List<Pair<Double, Double>>) {
        val sampleRate = 44100
        val totalDurationSec = tones.sumOf { it.second }
        val totalSamples = (totalDurationSec * sampleRate).toInt()
        val buffer = ShortArray(totalSamples)

        var sampleOffset = 0
        for ((freq, durationSec) in tones) {
            val count = (durationSec * sampleRate).toInt()
            val attackSamples = (0.01 * sampleRate).toInt().coerceAtLeast(1)
            for (i in 0 until count) {
                val t = i.toDouble() / sampleRate
                val rawSine = sin(2.0 * PI * freq * t)
                val envelope = when {
                    i < attackSamples -> i.toDouble() / attackSamples
                    else -> exp(-3.5 * (i - attackSamples).toDouble() / count)
                }
                val sampleValue = (rawSine * envelope * 24000.0).toInt().coerceIn(-32767, 32767)
                if (sampleOffset + i < buffer.size) {
                    buffer[sampleOffset + i] = sampleValue.toShort()
                }
            }
            sampleOffset += count
        }

        try {
            val audioTrack = AudioTrack.Builder()
                .setAudioAttributes(
                    AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_MEDIA)
                        .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                        .build()
                )
                .setAudioFormat(
                    AudioFormat.Builder()
                        .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
                        .setSampleRate(sampleRate)
                        .setChannelMask(AudioFormat.CHANNEL_OUT_MONO)
                        .build()
                )
                .setBufferSizeInBytes(buffer.size * 2)
                .setTransferMode(AudioTrack.MODE_STATIC)
                .build()

            audioTrack.write(buffer, 0, buffer.size)
            audioTrack.play()
            Thread.sleep((totalDurationSec * 1000).toLong() + 50)
            audioTrack.stop()
            audioTrack.release()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
