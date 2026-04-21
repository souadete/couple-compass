import silencieuxImg from "@/assets/archetype-silencieux.jpg";
import eloignesImg from "@/assets/archetype-eloignes.jpg";
import debordesImg from "@/assets/archetype-debordes.jpg";
import enConstructionImg from "@/assets/archetype-en-construction.jpg";
import complicesImg from "@/assets/archetype-complices-fatigues.jpg";
import survivantsImg from "@/assets/archetype-survivants.jpg";
import type { ArchetypeId } from "@/data/archetypes";

export const ARCHETYPE_IMAGES: Record<ArchetypeId, string> = {
  silencieux: silencieuxImg,
  eloignes: eloignesImg,
  debordes: debordesImg,
  "en-construction": enConstructionImg,
  "complices-fatigues": complicesImg,
  survivants: survivantsImg,
};
