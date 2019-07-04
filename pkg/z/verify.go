package z

import (
	"github.com/mojocn/base64Captcha"
)


// 创建图像验证码
func DemoCodeCaptchaCreate(verifyType string) (captchaId string, str string) {
	//config struct for digits
	//数字验证码配置
	var configD = base64Captcha.ConfigDigit{
		Height:     80,
		Width:      240,
		MaxSkew:    0.7,
		DotCount:   80,
		CaptchaLen: 5,
	}
	//config struct for audio
	//声音验证码配置
	var configA = base64Captcha.ConfigAudio{
		CaptchaLen: 6,
		Language:   "zh",
	}
	//config struct for Character
	//字符,公式,验证码配置
	var configC = base64Captcha.ConfigCharacter{
		Height:             60,
		Width:              240,
		//const CaptchaModeNumber:数字,CaptchaModeAlphabet:字母,CaptchaModeArithmetic:算术,CaptchaModeNumberAlphabet:数字字母混合.
		Mode:               base64Captcha.CaptchaModeNumber,
		ComplexOfNoiseText: base64Captcha.CaptchaComplexLower,
		ComplexOfNoiseDot:  base64Captcha.CaptchaComplexLower,
		IsShowHollowLine:   false,
		IsShowNoiseDot:     false,
		IsShowNoiseText:    false,
		IsShowSlimeLine:    false,
		IsShowSineLine:     false,
		CaptchaLen:         6,
	}

	// 输出

	switch {
	case verifyType == "audio":
		//创建声音验证码
		//GenerateCaptcha 第一个参数为空字符串,包会自动在服务器一个随机种子给你产生随机uiid.
		captchaId, capA := base64Captcha.GenerateCaptcha("", configA)
		//以base64编码
		base64stringA := base64Captcha.CaptchaWriteToBase64Encoding(capA)
		return captchaId,base64stringA
	case verifyType == "formula":
		//创建字符公式验证码.
		//GenerateCaptcha 第一个参数为空字符串,包会自动在服务器一个随机种子给你产生随机uiid.
		captchaId, capC := base64Captcha.GenerateCaptcha("", configC)
		//以base64编码
		base64stringC := base64Captcha.CaptchaWriteToBase64Encoding(capC)
		return captchaId,base64stringC
	default:
		//创建数字验证码.
		//GenerateCaptcha 第一个参数为空字符串,包会自动在服务器一个随机种子给你产生随机uiid.
		captchaId, capD := base64Captcha.GenerateCaptcha("", configD)
		//以base64编码
		base64stringD := base64Captcha.CaptchaWriteToBase64Encoding(capD)
		return captchaId,base64stringD
	}
}

// 验证图像验证码
func VerfiyCaptcha(idkey,verifyValue string) (code int){
	verifyResult := base64Captcha.VerifyCaptcha(idkey, verifyValue)
	if verifyResult {
		return 1
		//success
	} else {
		//fail
		return 0
	}
}
