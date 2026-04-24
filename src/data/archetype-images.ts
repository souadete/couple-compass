import silencieuxImg from "@/assets/archetype-silencieux.png";
import eloignesImg from "@/assets/archetype-eloignes.png";
import debordesImg from "@/assets/archetype-debordes.png";
import enConstructionImg from "@/assets/archetype-en-construction.png";
import complicesImg from "@/assets/archetype-complices-fatigues.png";
import survivantsImg from "@/assets/archetype-survivants.png";
import harmonieuxImg from "@/assets/archetype-harmonieux.png";
import type { ArchetypeId } from "@/data/archetypes";

export const ARCHETYPE_IMAGES: Record<ArchetypeId, string> = {
  silencieux: silencieuxImg,
  eloignes: eloignesImg,
  debordes: debordesImg,
  "en-construction": enConstructionImg,
  "complices-fatigues": complicesImg,
  survivants: survivantsImg,
  harmonieux: harmonieuxImg,
};
