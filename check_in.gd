extends Window

@onready var status_label: Label = $Panel/VBoxContainer/StatusLabel
@onready var button: Button = $Panel/VBoxContainer/Button


var texts = [
	"Remember to take frequent breaks!",
	"Remember to drink water!",
	"Stand up and stretch once in a while!",
	"Blink slowly and relax your eyes!",
	"Take a deep breath and reset your mind!",
	"Keep your workspace tidy—it helps your focus!",
	"Snack on something healthy when you feel tired!",
	"Step outside for a bit of fresh air!",
	"Stretch your fingers every now and then!",
	"Keep a small plant nearby; it’s calming!",
	"Remember to blink and avoid screen strain!",
	"Take a moment to smile at something silly!",
	"Rest your shoulders and roll them gently!",
	"Make a cozy spot for yourself to recharge!",
	"Take a short walk to clear your head!",
	"Keep hydrated; even cats need water too!",
	"Purr your worries away with a small break!",
	"Take a moment to pet something soft!",
	"Do a little dance when no one is watching!",
	"Stretch like you just woke up from a nap!",
	"Pause and enjoy a quiet moment!",
	"Look away from the screen and focus on a distant object!",
	"Let the sunlight warm your skin for a bit!",
	"Remember: every small effort counts!",
	"Take a micro-break and close your eyes!",
	"Give your brain a tiny snack of creativity!",
	"Roll on your back for a gentle stretch!",
	"Stand up and shake out your legs!",
	"Take a deep breath and let it out slowly!",
	"Keep a small treat nearby for motivation!",
	"Slowly wiggle your toes; it feels nice!",
	"Think of something that makes you happy!",
	"Curl up with a blanket and relax for a minute!",
	"Imagine chasing a butterfly—just for fun!",
	"Remember, naps can be very productive!",
	"Pause and listen to the sounds around you!",
	"Groom yourself mentally: tidy thoughts help!",
	"Stretch your arms toward the sky!",
	"Do a little paw stretch, I mean hand stretch!",
	"Take a moment to knead a pillow gently!",
	"Sit up straight—like a proud cat!",
	"Take a sip of water and imagine it as a treat!",
	"Look at something fluffy to boost your mood!",
	"Remember to pounce on opportunities!",
	"Step away from your desk for a mini adventure!",
	"Slowly rotate your neck to loosen tension!",
	"Take a playful approach to your next task!",
	"Curl up for a second with your favorite object!",
	"Chase a shadow or just imagine doing it!",
	"Pause and appreciate something small around you!",
	"Keep your paws—uh, hands—moving gently!",
	"Stretch, yawn, and repeat occasionally!",
    "Let yourself daydream for a brief moment!"
]

var responses = [
	"Yes boss!",
	"Understood!",
	"On it!",
	"Got it!",
	"Affirmative!",
	"Right away!",
	"Consider it done!",
	"Copy that!",
	"Roger roger!",
	"Will do!",
	"Aye aye!",
	"Absolutely!",
	"Of course!",
	"Righto!",
	"All clear!",
	"I’m on the case!",
	"Purrfect, noted!",
	"Meow, understood!",
	"Claws out, ready!",
    "Feline fine, got it!"
]


func _ready() -> void:
	status_label.text = texts.pick_random()
	button.text = responses.pick_random()


func _on_button_pressed() -> void:
	queue_free()
