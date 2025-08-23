import { useEffect } from "preact/hooks";

export const Scroll = () => {
  useEffect(() => {
    const page = globalThis.location.pathname;
    const scrollPosition =
      Number(sessionStorage.getItem(`scroll-position-${page}`)) ||
      0;
    globalThis.scrollTo(0, scrollPosition);
    return () => {
      sessionStorage.setItem(
        `scroll-position-${page}`,
        globalThis.scrollY.toString(),
      );
    };
  }, []);
  return null;
};
