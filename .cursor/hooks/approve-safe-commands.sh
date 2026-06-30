#!/bin/bash
#
# Fundmatch team hook: keurt veilige, vaak gebruikte commando's automatisch goed
# zodat het team kan doorbouwen zonder steeds te blijven hangen op goedkeuringen.
# Risicovolle commando's worden altijd aan de gebruiker voorgelegd.
#
# Werking:
#   - past een danger-lijst toe (push, deploy, rm -rf, drop table, sudo, doppler
#     secrets schrijven, enzovoort) en vraagt daarvoor altijd om bevestiging.
#   - keurt een allowlist van veilige dev-commando's automatisch goed
#     (tests, validate, build, lint, type-check, git add/commit, doppler run).
#   - alle overige commando's vraagt het standaard ter bevestiging.
#
# Autonome modus: bestaat het bestand .cursor/team-autorun-on, dan worden ook
# onbekende commando's automatisch goedgekeurd. De danger-lijst blijft altijd
# vragen, ook in autonome modus. Verwijder het bestand om weer voorzichtig te zijn.

input=$(cat)
command=$(printf '%s' "$input" | jq -r '.command // empty')

ask() {
  printf '%s' '{
    "permission": "ask",
    "user_message": "Dit commando kan iets wijzigen of naar buiten communiceren. Bekijk het even voordat je doorgaat.",
    "agent_message": "Een project-hook heeft dit commando als risicovol of onbekend gemarkeerd en vraagt om bevestiging."
  }'
  exit 0
}

allow() {
  printf '%s' '{ "permission": "allow" }'
  exit 0
}

# Leeg commando: niets te doen.
[ -z "$command" ] && allow

# Danger-lijst: altijd om bevestiging vragen. Wint van de allowlist.
danger='git[[:space:]]+push|--force|force-push|git[[:space:]]+reset[[:space:]]+--hard|git[[:space:]]+clean|git[[:space:]]+rebase|git[[:space:]]+merge|git[[:space:]]+config|--no-verify|supabase[[:space:]].*db[[:space:]]+push|supabase[[:space:]]+functions[[:space:]]+deploy|doppler[[:space:]]+secrets[[:space:]]+(set|upload|delete)|(^|[^a-z])vercel([[:space:]]|$)|eas[[:space:]]+(build|submit|update)|(^|[^a-z])rm[[:space:]]+-|(^|[^a-z])sudo([[:space:]]|$)|pkill|killall|(^|[^a-z])kill[[:space:]]|lsof|chmod|chown|npm[[:space:]]+publish|pnpm[[:space:]]+publish|drop[[:space:]]+table|truncate|delete[[:space:]]+from|alter[[:space:]]+table|grant[[:space:]]|(^|[^a-z])curl|(^|[^a-z])wget|(^|[^a-z])nc[[:space:]]'

if printf '%s' "$command" | grep -qiE "$danger"; then
  ask
fi

# Allowlist: veilige, vaak gebruikte dev-commando's automatisch goedkeuren.
safe='pnpm[[:space:]]+(run[[:space:]]+)?(validate|test|test:ci|test:watch|lint|lint:fix|type-check|typecheck|build|build:web|format|format:check|quality|quality:fix|pre-deploy)|pnpm[[:space:]]+install|pnpm[[:space:]]+i([[:space:]]|$)|turbo[[:space:]]+(run[[:space:]]+)?(build|lint|test|type-check|typecheck)|(^|[^a-z])(jest|vitest|tsc|eslint|prettier)([[:space:]]|$)|playwright[[:space:]]+test|(^|[^a-z])pact([[:space:]]|$)|git[[:space:]]+(status|diff|log|show|branch|add|commit|stash|rev-parse|fetch|remote|ls-files)|(^|[^a-z])node[[:space:]]+scripts/|scripts/|doppler[[:space:]]+run|supabase[[:space:]]+migration[[:space:]]+(list|new)|supabase[[:space:]]+--version|(^|[^a-z])(ls|pwd|echo|cat|head|tail|rg|grep|find|which|true|env|mkdir|touch|cd)([[:space:]]|$)'

if printf '%s' "$command" | grep -qiE "$safe"; then
  allow
fi

# Onbekend commando. In autonome modus goedkeuren, anders ter bevestiging.
if [ -f ".cursor/team-autorun-on" ]; then
  allow
fi

ask
